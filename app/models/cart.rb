class Cart < ApplicationRecord
  has_many :line_items
  has_many :vinyls, through: :line_items
  belongs_to :user

  def add_item(item_id)
    line_item = self.line_items.find_by(vinyl_id: item_id)
    if line_item
      line_item.quantity += 1
      line_item.save
      update_inventory(line_item.vinyl_id)
    else
      line_item = self.line_items.build(vinyl_id: item_id)
    end
    line_item
    update_inventory(line_item.vinyl_id)
  end

  def update_inventory(vinyl_id)
    vinyl = Vinyl.find(vinyl_id)
    vinyl.inventory -= 1
    vinyl.save
  end


  def total
    total = 0
    self.line_items.each do |line_item|
      vinyl = Vinyl.find(line_item.vinyl_id)
      total += (vinyl.price * line_item.quantity)
    end
    total
  end
end
