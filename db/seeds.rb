class Seed
  def self.start
    new.generate
  end

  def generate
    # create_categories
    create_projects
    create_users
    create_loans
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
      puts "Project #{i+1}: #{project.title} created!"
    end
  end

  def create_borrowers
    10.times do |i|
      user = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name,
        password: Faker::Internet.password
      )
      puts "User #{i+1}: #{user.username} created!"
    end
  end

  def create_loans
    20.times do |i|
      user  = User.find(Random.new.rand(1..10))
      Loan.create!(user_id: user.id, amount: Random.new.rand(100..1000), project_id: user.projects.shuffle.first.id)
      puts "Loan #{i}: Loan for #{user.name} created!"
    end
  end

end

Seed.start
