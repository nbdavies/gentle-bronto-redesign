# gentle-bronto-redesign
What makes this band website cool?

## Facebook integration
The site pings the Facebook Graph API for the Gentle Brontosaurus page posts if today's date is more recent than the most recent FB post cached in the database, and retrieves any new ones. 
Posts that mention Facebook events trigger a load of the corresponding event.
This means that by using Facebook in a very natural way, this site is automatically kept up to date.

## Bootstrap and custom styling
I tried out UI elements from Materialize, Bootstrap 4, and settled on the current version of Bootstrap.

## SVG social media icons

## Custom UI elements
### Side-scrolling news feed with even columns
The news feed loads the entire history's worth of posts in one JSON-based HTTP request. The other option being to load them as they come into view, I felt that one slightly larger request would be more mobile-friendly than a separate request for every half dozen posts.
The columns of results are supposed to be roughly even in length (they "break" after about 300 px). To do this, the HTML for each post is rendered, and the posts are grouped into pages according to how they add up length-wise. Then the first two pages are shown. This seems like a quite normal idea that I didn't find explored in depth elsewhere.

### Music player with side-by-side tracklist
You might notice that embedded players on Bandcamp and Soundcloud have the track list below the album art. I separated the two elements to have them side by side on larger screen sizes and inline on smaller screen sizes.

### Cards for upcoming events
I liked the idea of "cards" with background images, but in Bootstrap 4 it didn't look nice for me, so I cobbled together something like it on my own.

## Smooth scrolling to anchors
This was a short bit of jQuery code I found on CSS Tricks and modified a bit to taste.

## Background is from subtlepatterns.com