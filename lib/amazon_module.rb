module AmazonModule
  def clear_s3_object(object)
    s3 = AWS::S3.new(access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
    bucket = s3.buckets['alter-assets']
    object = bucket.objects[object.path[1..-1]]
    object.delete
  end
end