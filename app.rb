require 'cuba'
require 'redic'

redis = Redic.new

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
