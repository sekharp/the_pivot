class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
  end

  def add_project(project_id, amount)
    contents[project_id.to_s] ||= 0
    contents[project_id.to_s] += amount
  end

  def subtract_sticker(sticker_id)
    contents[sticker_id.to_s] -= 1 unless contents[sticker_id.to_s] < 1
    remove_sticker(sticker_id) if contents[sticker_id.to_s] < 1
  end

  def remove_sticker(sticker_id)
    contents.delete(sticker_id.to_s)
  end

  def total_count
    contents.count
  end

  def total_price
    subtotals = stickers.map do |cart_sticker|
      cart_sticker.quantity * cart_sticker.price
    end
    subtotals.sum
  end

  def count_of(sticker_id)
    contents[sticker_id.to_s]
  end

  def projects
    contents.map do |project_id, amount|
      project = Project.find(project_id)
      CartProject.new(project, amount)
    end
  end
end
