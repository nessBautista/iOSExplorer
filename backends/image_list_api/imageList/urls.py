from django.urls import path
from .views import ImageList, ListItemDetail

urlpatterns=[
    path("", ImageList.as_view(), name="api-image-list"),
    path("<int:pk>/", ListItemDetail.as_view(), name="api-item-detail"),
]