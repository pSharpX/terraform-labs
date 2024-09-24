resource "google_storage_bucket_object" "web_site" {
    name = "site.html"
    bucket = google_storage_bucket.web.name
    source = "./assets/site.html"
}

resource "google_storage_bucket_object" "web_photo" {
    name = "photo-small.jpg"
    bucket = google_storage_bucket.web.name
    source = "./assets/photo-small.jpg"
}

resource "google_storage_bucket_object" "assets_site" {
    name = "site.html"
    bucket = google_storage_bucket.assets.name
    source = "./assets/site.html"
}

resource "google_storage_bucket_object" "assets_photo" {
    name = "photo-small.jpg"
    bucket = google_storage_bucket.assets.name
    source = "./assets/photo-small.jpg"
}
