# Climbin

Self-quantified climbing experiment.

## Download the posts from Instagram

Firstly, enter the specific `virtualenv` to use `instaloader` cli. Below are two useful commands:

```bash
instaloader --profile dijkstrawberry # download profile data
```

```bash
instaloader profile dijkstrawberry # download all posts
```

## File structure

Each post should have these four components, with the same file name but different file format.

* `captions`: this directory contains caption content for a post.
    * File name example: `2024-04-02_00-52-42_UTC.txt`
* `metadata`: this directory contains the metadata for a post, e.g., like count.
    * File name example: `2024-11-18_03-56-58_UTC.json.xz`
    * We need to extract the `json` data from this compressed `xz` file. 
* `posts`: this directory contains the post content, maybe video or image.
    * File name example: `2024-12-17_02-21-17_UTC.mp4`
* `thumbnails`: this directory contains the thumbnail for a post, i.e., how it is displayed in the profile page.
    * File name example: `2024-12-15_03-33-36_UTC.jpg`

## Database

We store the climbs into a SQLite database. For each climb in the database, we store the following keys:

Here's the expanded table with an **Example** column filled based on the descriptions:  

| Key              | Type     | Description                                                                                                                                                                                      | Example                                                                                     |
|-------------------|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------|
| `videos`         | `list`   | Includes the paths to the relevant videos for this climb.                                                                                                                                      | `["/videos/climb1.mp4", "/videos/climb1_attempt2.mp4"]`                                     |
| `thumbnail`      | `str`    | The thumbnail image downloaded from Instagram. It should be an empty string if there's none.                                                                                                   | `"/images/climb1_thumbnail.jpg"`                                                           |
| `color`          | `dict`   | Refers to the color of the holds, with keys `name` and `hex`. If the color is inconsistent (e.g., in comp climbs), this is empty (`None`).                                                      | `{"name": "blue", "hex": "#0000FF"}`                                                       |
| `location`       | `dict`   | Refers to the location of the climbing gym.                                                                                                                                                     | `{"gym_name": "Gravity Climbing", "city": "Boston", "state": "MA"}`                         |
| `attempt_count`  | `list`   | Includes a max and min `int` in the list. Used to describe vague attempt counts (range) or precise counts (e.g., flash).                                                                         | `[3, 5]` for a range or `[1, 1]` for a flash                                               |
| `is_sent`        | `bool`   | Refers to whether the climb has been sent or not.                                                                                                                                               | `True`                                                                                      |
| `features`       | `dict`   | Describes the climb with keys `description` and `keywords`.                                                                                                                                     | `{"description": "A dynamic climb with a big dyno", "keywords": ["dyno", "power", "sloper"]}` |
| `gym_grade`      | `list`   | Grading of the climb provided by the gym, in the V-scale. Includes max and min `int` values in the list, similar to `attempt_count`.                                                            | `[6, 7]`                                                                                   |
| `personal_grade` | `list`   | Self-assessed grading of the climb, in the V-scale. The format is similar to `gym_grade`.                                                                                                       | `[6, 6]`                                                                                   |
| `climbed_with`   | `str`    | Lovely people I climbed with (e.g., yapping, climbing, joking, ping-ponging, etc.).                                                                                                             | `"John, Lisa, and Emily"`                                                                  |
| `note`           | `str`    | Notes relevant to this climb, such as reflections or nonsense, often scraped from Instagram posts.                                                                                              | `"Such a fun climb! Love the dynamic moves. Took 5 tries to figure out the start."`         |