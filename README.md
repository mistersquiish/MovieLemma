# *MovieLemma*

**MovieLemma** is a recommendation RESTful API Spring Boot service that uses the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

The recommendation algorithm gathers the cosine similarity between the current user and the rest of the users. It then sorts them by cosine similarity. It then selects top rated films by top similar users.
It then predicts the rating using cosin similarity and other users' ratings to create a composite predictive rating.

Time spent: **12** hours spent in total

## User Stories

The following **required** user stories are complete:

- [x] User can make API call by passing in current user
- [x] API call returns an array of Movies that are recommended and their predictive rating

## Notes

- Project was conceived as an interest in recommendation system and collaborative filtering from an MIS 375 lecture
- Built on Java Spring Boot as a way to familiarize myself with the framework and building an API service

## License

Copyright [2019] [Henry Vuong]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
