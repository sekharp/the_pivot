class Seed
  def self.start
    new.generate
  end

  def generate
    # create_categories
    create_projects
    create_users
    # create_orders
    # create_order_projects
  end

  # def create_categories
  #   @javascript_category = Category.create(title: "javascript")
  #   @ruby_category = Category.create(title: "ruby")
  #   @browser_category = Category.create(title: "browser")
  #   @git_category = Category.create(title: "git")
  #   @editor_category = Category.create(title: "editor")
  #   puts "#{Category.all.map(&:title).join(", ")} categories created."
  # end

  def create_projects
    20.times do |i|
      project = Project.create!(
        title: Faker::Commerce.product_name,
        description: Faker::Lorem.paragraph,
        image: "https://rudrakshagemstones.files.wordpress.com/2013/06/lord-ganesha.jpg",
        goal_amount: 500,
        user_id: 1
        )
      puts "Project #{i}: #{project.title} created!"
    end
  end

  def create_users
    user = User.create!(
      first_name: "John",
      last_name: "Doe",
      username: "jdoe",
      password: "password"
    )
    puts "User 1: #{user.full_name} created!"
  end

  def create_orders
  # 100.times do |i|
  #   user  = User.find(Random.new.rand(1..50))
  #   order = Order.create!(user_id: user.id)
  #   add_items(order)
  #   puts "Order #{i}: Order for #{user.name} created!"
  # end
    @order_1 = Order.create(status: "ordered",
                            user_id: @sekhar.id)
    @order_2 = Order.create(status: "paid",
                            user_id: @sekhar.id)
    @order_3 = Order.create(status: "cancelled",
                            user_id: @emily.id)
    @order_4 = Order.create(status: "completed",
                            user_id: @jason.id)
    @order_5 = Order.create(status: "completed",
                            user_id: @britney.id)
    puts "Orders with id #{Order.all.map(&:id).join(", ")} created."
  end

  def create_order_projects
    OrderSticker.create(quantity: 3,
                        order_id: @order_1.id,
                        sticker_id: @nodejs_sticker.id)
    OrderSticker.create(quantity: 2,
                        order_id: @order_1.id,
                        sticker_id: @reactjs_sticker.id)
    OrderSticker.create(quantity: 5,
                        order_id: @order_1.id,
                        sticker_id: @ruby_sticker.id)
    OrderSticker.create(quantity: 4,
                        order_id: @order_2.id,
                        sticker_id: @vim_sticker.id)
    OrderSticker.create(quantity: 2,
                        order_id: @order_2.id,
                        sticker_id: @chrome_sticker.id)
    OrderSticker.create(quantity: 3,
                        order_id: @order_3.id,
                        sticker_id: @nodejs_sticker.id)
    OrderSticker.create(quantity: 6,
                        order_id: @order_4.id,
                        sticker_id: @reactjs_sticker.id)
    OrderSticker.create(quantity: 2,
                        order_id: @order_5.id,
                        sticker_id: @angularjs_sticker.id)
  end
end

Seed.start
