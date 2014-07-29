- Login with spotify (necessary to get most played songs?) -Spencer
- Retrieve top 25 most played artists from spotify        -Spencer
- ~~Connect with google to post to calendar~~
  Or possibly as email                                    -Ilana
- Handle when bandsintown returns no results              -Randall
- Get API keys everyone!
- Bootstrap                                               -Ilana
- About page                                              -Randall
- Set up models, controllers, and view                    -Randall

Optional features
- Add threading for multiple artists                      -?
- Autocomplete for artists list (full library)
- Select all artists
- Find related artists (spotify?)

Models
- Users (have many artists, events through artists, emails through events)
- Artists (have many events)
- Events (belongs to artist)
- Email (belongs to event)
- Requests (belongs to user)
