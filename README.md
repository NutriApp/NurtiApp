# Project - *NutriApp*

**NutriApp** is an app that let users monitor their food intakes and converse with professional or friends to help them create a supportive community for their well being.

## User Stories

The following functionality is completed:

- [x] Users can sign up via Parse
- [x] pull out menu
- [x] Users can make goals/nutrition plan in their profile
- [x] Upload pictures
	- [x] Via Parse or other hosting 
- [x] User settings
- [x] Update Progress

Optionals:
- [ ] Supporters/Supporting Feed
    - [ ] Add/Delete Support
    - [ ] Comment on feed
    - [ ] Like
- [ ] View progress calendar of nutrition
- [ ] Alerts and notification when other rates/review their diet plan
- [ ] Videos of healthy food
    - [ ] User recorded video
- [ ] Pull top health tip of the day via Twitter?
- [ ] Link to store selling healthy food
- [ ] Healthy Recipes

Advance Optional: 
- [ ] Users can check into or comment on a restaurant on their progress report regarding it's healthinest using Yelp API
    - [ ] Application consolidates all the user's data and create a map showing locations of healthy food
        - [ ] Google Map API + Parse data
    - [ ] Restaurant users find healthy


Funny:
- [ ] Healthy snack timer: Last time you ate something healthy

Parse Server Data Schema:

    [Users]
        User_ID - Int
        Profile_Image_URL - NSURL
        Name - String
        Age - Int
        Last_Updated - NSDate
        .
        .
        [Plan]
            Goal - String
            [Food Group]
                Vegi - String
                    Serving - Int
                .
                .
        [Supporters/Supporting]
            [Users]
                User_ID - Int
                Relationship - String

    [Media]
        User_ID - Int
        Profile_Image_Url - NSURL
        Food_Image - NSURL
        Caption - String
        Created_At - NSDate
        Progress_Percentage
        Like_Count - int
        [Comments]
            Meal_type - Int
            Emocon - Int
            User_ID - Int
            Comment - String

<img src='http://i.imgur.com/jKl6VFH.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src = 'http://i.imgur.com/VPv52xT.gif' title = 'Video Walkthrough' width='' alt='Video Walkthrough' />

66% Mark

<img src = 'http://i.imgur.com/JdD8eqt.gif' title = 'Video Walkthrough' width='' alt='Video Walkthrough' />

<img src = 'http://i.imgur.com/wohSPXL.gif' title = 'Video Walkthrough' width='' alt='Video Walkthrough' />

All Required Complete!

<img src = 'http://i.imgur.com/WJ53qrw.gif' title = 'Video Walkthrough' width='' alt='Video Walkthrough' />

<img src = 'http://i.imgur.com/tsOvqBD.gif' title = 'Video Walkthrough' width='' alt='Video Walkthrough' />



Consideration:

- What is your product pitch?
    - Start with a problem statement and follow up with a solution.
        - There is no app that allows user to track serving of food and have supporters review it
    - Focus on engaging your audience with a relatable need.
        - With a community of friends supporting you, you are more likely to stick to your goal

- Who are the key stakeholders for this app?
    - Who will be using this?
        - Someone who is watching what they are eating
    What will they be using this for?
        - Healthy lifestyle and feedback

- What are the core flows?
    - What are the key functions?
        - Set goals and update daily progress using slide bars and pictures
        - Comments regarding their activity
    - What screens will each user see?
        - Home feed, Profile, Progress, Supporter, Menu, and Settings

- What will your final demo look like?
    - Describe the flow of your final demo
        - User logs in and see their past activity and reads comments related to their activity
        - User updates their progress of the day and takes a picture of some food they ate
        - User goes to supporter page and reviews their supporter
        - User finds a supporter inactive and deletes them
        - User updates their goal
        - User updates their weight
        - User receives a notification and reads it
        - User adds a new supporter

- What mobile features do you leverage?
    - Leverage at least two mobile-oriented features (i.e. maps and camera)
        - Camera
        - Instant notification
        - Messaging

- What are your technical concerns?
    - What technical features do you need help or resources for?
        - Notification
        - Parse Database
        - Managing Parse data related to image hosting and retrieving URL instead
        - Calendar

## License

    Copyright [2016] [Kevin Tran & Hannah Werbel]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
