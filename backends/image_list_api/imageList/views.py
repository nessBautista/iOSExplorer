from django.http import HttpResponse
from django.views import View 
import json
from .models import ListItem

class ListItemDetail(View):
    def get(self, request, pk):
        item = ListItem.objects.get(pk=pk)
        item_json = json.dumps(
            dict(
                id=item.pk,
                title=item.title,
                link = item.link,
                slug=item.slug,
            )
        )
        return HttpResponse(item_json)

class ImageList(View):
    def get(self, request):
        items = ListItem.objects.all()        
        list_json = json.dumps(
            [
                dict(
                    id=item.pk,
                    title=item.title,
                    link = item.link,
                    slug=item.slug,
                )
                for item in items
            ]
        )
        return HttpResponse(list_json)

# Create your views here.
