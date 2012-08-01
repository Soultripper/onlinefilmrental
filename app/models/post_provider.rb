class PostProvider < ActiveRecord::Base

  attr_accessible :film_provider_id, :post_type, :disc_one, :disc_two, :disc_three

  belongs_to :film_provider

  scope :limited, where('post_type=2')
  scope :unlimited, where('post_type=1')

  def one
    return unless disc_one
    @one ||= OpenStruct.new(YAML.load(disc_one))
  end

  def two
    return unless disc_two
    @two ||= OpenStruct.new(YAML.load(disc_two))
  end

  def three
    return unless disc_three
    @three ||= OpenStruct.new(YAML.load(disc_three))
  end
end
