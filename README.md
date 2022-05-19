Predicting the stock price of GameStop using r/wallstreetbets
================

## Looking back to spring 2021

In the beginning of 2021 GameStop was an almost bankrupt company. Then
something strange happend on the subreddit r/wallstreetbets. This
subredit known for the “risk seeking” gamblers collectively decided to
pump up the GameStop price to 420,69$. In addition to a potential big
gain for the gamblers and a funny meme the redditors also wanted to
challenge Wallstreet which had a large amount of short positions on
GameStop. In the aftermath, large Hedgfonds lost [billions of
dollars](https://www.cnbc.com/2021/01/29/gamestop-short-sellers-are-still-not-surrendering-despite-nearly-20-billion-in-losses-this-year.html).

![](README_files/figure-gfm/picture%20of%20GameStop%20Stock-1.png)<!-- -->

## What i tried to achieve

I asked myself weather or not the discussion of the GameStop stock in
the subreddit influenced the Stock price persistently over the whole
year of 2021. To answer this question, I scrapped XXXX posts with a
total of xxx comments and analysed the speech sentiment using an NLP
algorithm. Then I used the per day averaged sentiment to perform a
regression on the stock price controlling for the general market
movement and time lags.

### How to get the data

Getting the comments and posts from the subreddit posed the biggest
challenge. Despite the public accessible website the usage of a
web-scrapper was not an option. Reddit limits the amount of comments an
automated tool like *RedditExtractoR* (Rivera 2022) can return from
Reddit. After trying out a few option i switched from R to Python an
used the PRAW package xxxx cite

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-RedditExtractoR" class="csl-entry">

Rivera, Ivan. 2022. *RedditExtractoR: Reddit Data Extraction Toolkit*.
<https://CRAN.R-project.org/package=RedditExtractoR>.

</div>

</div>
