require 'cuba'
require 'redic'

redis = Redic.new ENV['REDIS_URL'] || 'redis://127.0.0.1:6379'

Cuba.define do
  on get do
    locations = redis.call 'LRANGE', 'locations', 0, -1
    res.write locations
  end

  on post do
    redis.call 'LPUSH', 'locations', req.body.read
    res.status = 201
  end
end
