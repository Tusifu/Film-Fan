# FILM FAN 

## Requirements

1. Flutter v2.10.3
2. Dart v2.16.1

## Get Started

1. Checkout to master branch
2. Clone the project.
3. Create .env file in the root directory add env content, that file
    will be attached to an email of git repo link and .env as well.

4. run: flutter clean
5. run: flutter pub get
6. run: flutter run


## Notes

1. On Movie detail page rating movie requires to be having a guest session id
    as the documentation suggests, to this session id you have to 
    request a service which generate new token. 
    ref link: https://developers.themoviedb.org/3/authentication/create-guest-session
    more info : https://developers.themoviedb.org/3/authentication/how-do-i-generate-a-session-id

2. Every image poster doesn't fit exactly in the card I built.


## Navigation through pages
 
1. First page in home page which list all playing movies
    - List all playing movies
    - Heart Icon Button to list movies in favorites.

    
2. when you click on one you open the detail page of selected movies
    - add to favorites page and remove  if it was already in favorites
    - detail page has movie basic information
    - detail page has movie genres
    - detail page has a list of similar movies if none , text 'no similar movie is displayed' 

3. Favourites page (favorites are saved on local storage of the device
    and it used sqlflite 3rd party for managing local storage)
    
    



