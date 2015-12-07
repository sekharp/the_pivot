class Seed
  def self.start
    new.generate
  end

  def generate
    create_categories
    create_roles
    create_admins
    create_borrowers
    create_projects
    create_lenders
    create_loans
    create_sample_accounts
  end

  def create_categories
    Category.create(title: "Andhra Pradesh")
    Category.create(title: "Telangana")
    Category.create(title: "Karnataka")
    Category.create(title: "Tamil Nadu")
    Category.create(title: "Kerala")
    Category.create(title: "Madhya Pradesh")
    Category.create(title: "Uttar Pradesh")
    Category.create(title: "Maharashtra")
    Category.create(title: "Rajasthan")
    Category.create(title: "Punjab")
    Category.create(title: "Gujarat")
    Category.create(title: "West Bengal")

    puts "#{Category.all.map(&:title).join(", ")} categories created, #{Category.count} in total."
  end

  def create_roles
    @lender = Role.create!(name: "lender")
    @borrower = Role.create!(name: "borrower")
    @admin = Role.create!(name: "admin")
    puts "#{@lender.name}, #{@borrower.name}, #{@admin.name} roles created."
  end

  def create_admins
    5.times do |i|
      admin = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name + "#{i}",
        password: Faker::Internet.password
      )

      admin.roles << @admin
    end
    puts "#{Role.find_by(name: "admin").users.count} admins created!"
  end

  def create_borrowers
    20.times do |i|
      borrower = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name + "#{i}",
        password: Faker::Internet.password
      )

      borrower.roles << @borrower
    end
    puts "#{Role.find_by(name: "borrower").users.count} borrowers created!"
  end

  def create_projects
    project_status = ["Pending", "Cancelled", "Active", "Completed"]
    40.times do |i|
      project = Project.create!(
        title: Faker::Commerce.product_name + "#{i}",
        description: Faker::Lorem.paragraph,
        image: "https://rudrakshagemstones.files.wordpress.com/2013/06/lord-ganesha.jpg",
        goal_amount: Random.new.rand(10000..20000),
        user_id: Role.find_by(name: "borrower").users.shuffle.first.id,
        category_id: Category.all.shuffle.first.id,
        status: project_status.shuffle.pop
        )
    end
    puts "#{Project.all.count} projects created!"
  end

  def create_lenders
    30.times do |i|
      lender = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name + "#{i}",
        password: Faker::Internet.password
      )

      lender.roles << @lender
    end
    puts "#{Role.find_by(name: "lender").users.count} lenders created!"
  end

  def create_loans
    100.times do |i|
      lender = Role.find_by(name: "lender").users.shuffle.first
      project = Project.all.shuffle.first
      Loan.create!(user_id: lender.id, amount: Random.new.rand(100..1000), project_id: project.id)
    end
    puts "#{Loan.all.count} loans created!"
  end

  def create_sample_accounts
    lender = User.create!(
      first_name: "lender",
      last_name: "lender",
      username: "lender",
      password: "password"
    )
    lender.roles << @lender

    borrower = User.create!(
      first_name: "borrower",
      last_name: "borrower",
      username: "borrower",
      password: "password"
    )
    borrower.roles << @borrower

    combined = User.create!(
      first_name: "combined",
      last_name: "combined",
      username: "combined",
      password: "password"
    )
    combined.roles << @lender
    combined.roles << @borrower

    admin = User.create!(
      first_name: "admin",
      last_name: "admin",
      username: "admin",
      password: "password"
    )
    admin.roles << @admin
    puts "Sample accounts created for lender, borrower, combined and admin. The password is password for each."
  end

end

Seed.start
