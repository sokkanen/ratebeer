class TopJob
  include SuckerPunch::Job

  def perform
    Rails.cache.write("beer_top_3", Beer.top(3))
    Rails.cache.write("brewery_top_3", Brewery.top(3))
    Rails.cache.write("style_top_3", Style.top(3))
    puts "Top 3 caches updated."
    TopJob.perform_in(5.minutes)
  end
end
