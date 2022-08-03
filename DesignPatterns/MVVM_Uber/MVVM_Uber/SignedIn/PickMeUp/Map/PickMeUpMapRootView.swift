//
//  PickMeUpMapRootView.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 03/08/22.
//
import UIKit

import MapKit
import Combine

class PickMeUpMapRootView: MKMapView {

  // MARK: - Properties
  let viewModel_real: PickMeUpMapViewModel
  private var subscriptions = Set<AnyCancellable>()
  let defaultMapSpan = MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006)
  let mapDropoffLocationSpan = MKCoordinateSpan(latitudeDelta: 0.017, longitudeDelta: 0.017)
  var imageCache: ImageCache

  // MARK: - Methods
  init(frame: CGRect = .zero, viewModel: PickMeUpMapViewModel, imageCache: ImageCache) {
	self.viewModel_real = viewModel
	self.imageCache = imageCache
	super.init(frame: frame)
	delegate = self
	bindViewModel()
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
	fatalError("init(coder:) is not supported by PickMeUpMapRootView.")
  }

  func bindViewModel() {
	viewModel_real
	  .$pickupLocation
	  .receive(on: DispatchQueue.main)
	  .map(MapAnnotationType.makePickupLocationAnnotation(for:))
	  .sink { [weak self] annotation in
		self?.pickupLocationAnnotation = annotation
	  }.store(in: &subscriptions)

	viewModel_real
	  .$dropoffLocation
	  .receive(on: DispatchQueue.main)
	  .map(MapAnnotationType.makeDropoffLocationAnnotation(for:))
	  .sink { [weak self] annotation in
		guard let annotation = annotation else { return }
		self?.dropoffLocationAnnotation = annotation
		self?.zoomOutToShowDropoffLocation(pickupCoordinate: annotation.coordinate)
	  }.store(in: &subscriptions)
  }

  var viewModel = MapViewModel() {
	didSet {
	  let currentAnnotations = (annotations as! [MapAnnotation]) // In real world, cast instead of force unwrap.
	  let updatedAnnotations = viewModel.availableRideLocationAnnotations
		+ viewModel.pickupLocationAnnotations
		+ viewModel.dropoffLocationAnnotations

	  let diff = MapAnnotionDiff.diff(currentAnnotations: currentAnnotations, updatedAnnotations: updatedAnnotations)
	  if !diff.annotationsToRemove.isEmpty {
		removeAnnotations(diff.annotationsToRemove)
	  }
	  if !diff.annotationsToAdd.isEmpty {
		addAnnotations(diff.annotationsToAdd)
	  }

	  if !viewModel.dropoffLocationAnnotations.isEmpty {
		zoomOutToShowDropoffLocation(pickupCoordinate: viewModel.pickupLocationAnnotations[0].coordinate)
	  } else {
		zoomIn(pickupCoordinate: viewModel.pickupLocationAnnotations[0].coordinate)
	  }
	}
  }

  var pickupLocationAnnotation: MapAnnotation? {
	didSet {
	  guard oldValue != pickupLocationAnnotation else { return }
	  removeAnnotation(oldValue)
	  addAnnotation(pickupLocationAnnotation)
	  guard let annotation = pickupLocationAnnotation else { return }
	  zoomIn(pickupCoordinate: annotation.coordinate)
	}
  }

  var dropoffLocationAnnotation: MapAnnotation? {
	didSet {
	  guard oldValue != dropoffLocationAnnotation else { return }
	  removeAnnotation(oldValue)
	  addAnnotation(dropoffLocationAnnotation)
	}
  }

  func removeAnnotation(_ annotation: MapAnnotation?) {
	guard let annotation = annotation else { return }
	removeAnnotation(annotation)
  }

  func addAnnotation(_ annotation: MapAnnotation?) {
	guard let annotation = annotation else { return }
	addAnnotation(annotation)
  }

  func zoomIn(pickupCoordinate: CLLocationCoordinate2D) {
	let center = pickupCoordinate
	let span = defaultMapSpan
	let region = MKCoordinateRegion(center: center, span: span)
	setRegion(region, animated: false)
  }

  func zoomOutToShowDropoffLocation(pickupCoordinate: CLLocationCoordinate2D) {
	let center = pickupCoordinate
	let span = mapDropoffLocationSpan
	let region = MKCoordinateRegion(center: center, span: span)
	setRegion(region, animated: true)
  }

}

extension PickMeUpMapRootView: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
	guard let annotation = annotation as? MapAnnotation else {
	  return nil
	}
	let reuseID = reuseIdentifier(forAnnotation: annotation)
	guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) else {
	  return MapAnnotationView(annotation: annotation, reuseIdentifier: reuseID, imageCache: imageCache)
	}
	annotationView.annotation = annotation
	return annotationView
  }

  func reuseIdentifier(forAnnotation annotation: MapAnnotation) -> String {
	return annotation.imageIdentifier
  }
}
