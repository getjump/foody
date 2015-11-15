Aws.config.update({
  region: 'eu-central-1',
  credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'] || "AKIAJXYZ2PT4KEMMJL2Q", ENV['AWS_SECRET_ACCESS_KEY'] || "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"),
  :s3 => { :region => 'eu-central-1' }
})

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['S3_BUCKET'])
