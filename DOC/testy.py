from pytrends.request import TrendReq

pytrends = TrendReq(hl='en-US', tz=360)  # 'hl' for language, 'tz' for timezone offset (e.g., US CST)
# Get worldwide trending searches
trending_searches_worldwide = pytrends.trending_searches()

# Get trending searches for a specific location (e.g., United States)
trending_searches_us = pytrends.trending_searches(pn='united_states')

print("Worldwide Trending Searches:")
print(trending_searches_worldwide)  # Show top trending searches worldwide

print("\nUnited States Trending Searches:")
print(trending_searches_us)  # Show top trending searches in the United States
