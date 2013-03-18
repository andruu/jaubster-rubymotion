class Search

  DB_FILE = 'search.dat'.freeze

  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  columns search:     :string,
          location:   :string,
          saved:      :boolean,
          created_at: :date

  def self.create(*args)
    options = args[0]
    p options
    # p Search.all
    # p Search.find do |s|
    #   s.saved == options[:saved]
    # end
    # p Search.where(:saved).eq(options[:saved]).where(:search).eq(options[:search]).all
    # p Search.where(:location).eq('San Francisco, California').where(:search).eq('Ruby on Rails').where(:saved).eq(true)
    # p Search.all
    
    p Search.where(:location).eq('San Francisco, California').where(:search).eq('').where(:saved).eq(true).all.count
    # p "Search.where(:location).eq('#{options[:location]}').where(:search).eq('#{options[:search]}').where(:saved).eq(#{options[:saved]}).all.count"
    # p Search.where(:location).eq(options[:location]).where(:search).eq(options[:search] || "").where(:saved).eq(options[:saved]).all.count
    # return if Search.where(:location).eq(options[:location]).where(:search).eq(options[:search] || "").where(:saved).eq(options[:saved]).all.count >= 1
    super
    Search.serialize_to_file DB_FILE
  end

  def self.destroy_all
    super
    Search.serialize_to_file DB_FILE
  end
end