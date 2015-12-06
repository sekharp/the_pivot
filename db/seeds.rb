class Seed
  def self.start
    new.generate
  end

  def generate
    create_categories
    create_roles
    create_platform_admins
    create_borrowers
    create_projects
    create_lenders
    create_loans
  end

  def create_categories
    10.times do |i|
      category = Category.create(title: Faker::Lorem.word)
    end
    puts "#{Category.all.map(&:title).join(", ")} categories created, #{Category.count} in total."
  end

  def create_roles
    @lender = Role.create!(name: "lender")
    @borrower = Role.create!(name: "borrower")
    @platform_admin = Role.create!(name: "platform_admin")
    puts "#{@lender.name}, #{@borrower.name}, #{@platform_admin.name} roles created."
  end

  def create_platform_admins
    5.times do |i|
      platform_admin = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name,
        password: Faker::Internet.password
      )

      platform_admin.roles << @platform_admin

      puts "Platform Admin #{i+1}: #{platform_admin.username} created!"
    end
  end

  def create_borrowers
    10.times do |i|
      borrower = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name,
        password: Faker::Internet.password
      )

      borrower.roles << @borrower

      puts "Borrower #{i+1}: #{borrower.username} created!"
    end
  end

  def create_projects
    20.times do |i|
      project = Project.create!(
        title: Faker::Commerce.product_name,
        description: Faker::Lorem.paragraph,
        image: "https://rudrakshagemstones.files.wordpress.com/2013/06/lord-ganesha.jpg",
        goal_amount: Random.new.rand(10000..20000),
        user_id: Role.find_by(name: "borrower").users.shuffle.first.id,
        category_id: Category.all.shuffle.first.id
        )
      puts "Project #{i+1}: #{project.title} created!"
    end
  end

  def create_lenders
    20.times do |i|
      lender = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name,
        password: Faker::Internet.password
      )

      lender.roles << @lender

      puts "Lender #{i+1}: #{lender.username} created!"
    end
  end

  def create_loans
    40.times do |i|
      lender = Role.find_by(name: "lender").users.shuffle.first
      project = Project.all.shuffle.first
      Loan.create!(user_id: lender.id, amount: Random.new.rand(100..1000), project_id: project.id)
      puts "Loan #{i+1}: Loan for #{lender.username} created!"
    end
  end

end

Seed.start
