from django.db import models

class ListItem(models.Model):
    title = models.CharField(max_length=63)
    slug = models.SlugField(max_length=63)
    link = models.URLField(max_length=255)

    class Meta:
        ordering= ["title"]

    def __str__(self):
        return f"{self.link}"
