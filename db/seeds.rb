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
    categories = ["Andhra Pradesh",
                  "Telangana",
                  "Karnataka",
                  "Tamil Nadu",
                  "Kerala",
                  "Madhya Pradesh",
                  "Uttar Pradesh",
                  "Maharashtra",
                  "Rajasthan",
                  "Punjab",
                  "Gujarat",
                  "West Bengal"]

    categories.each do |title|
      Category.create!(title: title)
      puts "Created Category: #{title}"
    end

    puts "Created #{categories.count} categories."
  end

  def create_roles
    @lender = Role.create!(name: "lender")
    @borrower = Role.create!(name: "borrower")
    @admin = Role.create!(name: "admin")
    puts "#{@lender.name}, #{@borrower.name}, #{@admin.name} roles created."
  end

  def create_admins
    n = 5
    n.times do |i|
      admin = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name + "#{i}",
        password: Faker::Internet.password,
        bio: Faker::Lorem.paragraph(2),
        image: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
      )
      admin.roles << @admin
      puts "#{admin.first_name} #{admin.last_name} created."
    end
    puts "#{n} admins created!"
  end

  def create_borrowers
    n = 20
    n.times do |i|
      borrower = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name + "#{i}",
        password: Faker::Internet.password,
        bio: Faker::Lorem.paragraph(2),
        image: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
      )
      borrower.roles << @borrower
      puts "#{borrower.first_name} #{borrower.last_name} created"
    end
    puts "#{n} borrowers created!"
  end

  def create_projects
    project_statuses = ["Pending", "Cancelled", "Active", "Completed"]
    borrowers = Role.find_by(name: "borrower").users
    categories = Category.all
    n = 40
    n.times do |i|
      project = Project.create!(
        title: Faker::Commerce.product_name + " #{i}",
        description: Faker::Lorem.paragraph,
        image: "http://cliparts.co/cliparts/Lid/5A6/Lid5A66zT.png",
        goal_amount: Random.new.rand(10000..20000),
        user_id: borrowers[Random.new.rand(0..(borrowers.count - 1))].id,
        category_id: categories[Random.new.rand(0..(categories.count - 1))].id,
        status: project_statuses[Random.new.rand(0..(project_statuses.count - 1))]
        )
      puts "#{project.title} Project created!"
    end
    puts "#{n} projects created!"
  end

  def create_lenders
    n = 30
    n.times do |i|
      lender = User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.user_name + "#{i}",
        password: Faker::Internet.password,
        bio: Faker::Lorem.paragraph(2),
        image: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
      )
      lender.roles << @lender
      puts "Lender: #{lender.first_name} #{lender.last_name} created."
    end
    puts "#{n} lenders created!"
  end

  def create_loans
    lenders = Role.find_by(name: "lender").users
    projects = Project.all
    n = 100
    n.times do |i|
      lender_id = lenders[Random.new.rand(0..(lenders.count - 1))].id
      project_id = projects[Random.new.rand(0..(projects.count - 1))].id
      Loan.create!(user_id: lender_id,
                   amount: Random.new.rand(100..1000),
                   project_id: project_id)
    end
    puts "#{n} loans created!"
  end

  def create_sample_accounts
    lender = User.create!(
      first_name: "lender",
      last_name: "lender",
      username: "lender",
      password: "password",
      bio: Faker::Lorem.paragraph(2),
      image: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
    )
    lender.roles << @lender
    puts "Created 'lender'"

    borrower = User.create!(
      first_name: "borrower",
      last_name: "borrower",
      username: "borrower",
      password: "password",
      bio: Faker::Lorem.paragraph(2),
      image: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
    )
    borrower.roles << @borrower
    puts "Created 'borrower'"

    combined = User.create!(
      first_name: "combined",
      last_name: "combined",
      username: "combined",
      password: "password",
      bio: Faker::Lorem.paragraph(2),
      image: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
    )
    combined.roles << @lender
    combined.roles << @borrower
    puts "Created 'combined'"

    admin = User.create!(
      first_name: "admin",
      last_name: "admin",
      username: "admin",
      password: "password",
      bio: Faker::Lorem.paragraph(2),
      image: "http://www.bankingtech.com/wp-content/blogs.dir/94/files/2013/11/India-women.jpg"
    )
    admin.roles << @admin
    puts "Created 'admin'"
    puts "Sample accounts created for lender, borrower, combined and admin. The password is password for each."
  end

end

Seed.start
