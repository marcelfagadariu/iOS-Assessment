## Overview

This project contains an iOS mobile application assessment.

## Libraries Used

- **Atlantis**: [Atlantis](https://github.com/ProxymanApp/atlantis) for debugging requests purposes.
- **Kingfisher**: [Kingfisher](https://github.com/onevcat/Kingfisher) for image caching.
- **SwiftAsyncNetwork**: [SwiftAsyncNetwork](https://github.com/marcelfagadariu/SwiftAsyncNetworking) which was created by me to simplify asynchronous network operations.

### Requirmenets

As part of the hiring process, we would like to see a small iOS app fully authored by you. Once submitted, your code will be reviewed by your potential colleagues, who will dissect it with the same care as if it were a PR to be merged into our codebase. Keep this in mind, as we will equally look at how you approach versioning, code style consistency, naming, testing strategy, code layering, architecture, lifecycle gotchas, handling of failures, application of good programming practices, etc.

After the review, the reviewers will get together and attempt to understand if you could be a good fit for the team. If so, a fun conversation awaits! You’ll be invited to a follow-up interview to discuss the code from your assessment and all the interesting things related to good programming. If your approach is not to our liking, you’ll still be given feedback about what we did and did not appreciate about the code. This is to make sure you also get something in return for taking the time to do our test.

## Requirements

These are the requirements for our programming assessment:

- **API**: Use the Dutch Rijksmuseum API, see documentation [here](https://data.rijksmuseum.nl/object-metadata/api/) (API key to use: `0fiuZFh4`).
- **App Structure**: 
  - We would like the app to have at least two screens:
    - **Overview Page**:
      - Should display a list of items (preferably a collection view).
      - Should have sections with headers.
      - Items should have text and image.
      - Page should be paginated.
    - **Detail Page**:
      - Should provide more details about the selected item.
- **Loading and Converting JSON**: 
  - Should be asynchronous.
  - A loading icon/animation should be shown.
- **Automated Tests**: 
  - Should be present (full coverage not needed, of course).
- **Constraints**: 
  - No SwiftUI.
  - No xib files or storyboards.

## Review Criteria

Things we will be focusing on when reviewing:

- Architecture used.
- Tests written.
- Handling of failures (e.g., failed network calls).

You’re free to use whichever library you’re used to in your own projects, without limitations. Just give us a heads-up if you reach for something more exotic that heavily impacts what the implementation looks like.



