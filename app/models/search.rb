class Search < NanoStore::Model
  attribute :search
  attribute :location
  attribute :saved
  attribute :created_at

  def self.create(*args)
    return unless Search.find(location: args.first[:location], search: args.first[:search]).blank?
    args.first[:created_at] = Time.now
    super
  end
end