class Seed
  def self.start
    new.generate
  end

  def generate
    create_categories
    create_roles
    # create_admins
    # create_borrowers
    # create_projects
    # create_lenders
    # create_loans
    # create_sample_accounts
    create_sample_data
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

  def create_sample_data
    jeff = User.create!(
      first_name: "Jeff",
      last_name: "Casimir",
      username: "jcasimir",
      password: "password",
      bio: "Executive Director of the Turing School of Software & Design, based in Denver, Colorado. I love microfinance.",
      image: "http://frelow.smugmug.com/CodeNewbie/i-8hHRQd7/0/O/jeff.jpg"
    )
    jeff.roles << @lender

    josh = User.create!(
      first_name: "Josh",
      last_name: "Mejia",
      username: "josh@turing.io",
      password: "password",
      bio: "Software Lead and Instructor at the Turing School of Software & Design, based in Denver, Colorado. I also love microfinance.",
      image: "https://pbs.twimg.com/profile_images/548068847677231104/WPu1nCfp.jpeg"
    )
    josh.roles << @lender

    leelavathi = User.create!(
      first_name: "Leelavathi",
      last_name: "Paladugu",
      username: "lpaladugu",
      password: "password",
      bio: "Resident of Mustabada, Andhra Pradesh. Raising money to expand my agricultural business and support my family.",
      image: "http://www2.robertharding.com/preview/RM/RH/VERTICAL/1161-4802.jpg"
    )
    leelavathi.roles << @borrower

    andrew = User.create!(
      first_name: "Andrew",
      last_name: "Carmer",
      username: "andrew@turing.io",
      password: "password",
      bio: "Resident of Jamnagar, Gujarat. Raising money to buy a new rickshaw to support my driving business and by extension my family.",
      image: "http://www.hotboxdenver.com/imgs/ac_linkhead.jpg"
    )
    andrew.roles << @borrower

    gopal = User.create!(
      first_name: "Gopal",
      last_name: "Patel",
      username: "gpatel",
      password: "password",
      bio: "Resident of Jamnagar, Gujarat. Raising money to buy a new rickshaw to support my driving business and by extension my family.",
      image: "http://thumbs.dreamstime.com/x/happy-indian-villager-21530522.jpg"
    )
    gopal.roles << @borrower

    buffalo = leelavathi.projects.create!(
      title: "Buy a Buffalo",
      description: "My family is looking to buy one buffalo, to provide milk for our family and work on our small rice and lentil farm.",
      image: "http://www.releaseinternational.org/wp-content/uploads/2013/05/indian_water_buffalo.jpg",
      goal_amount: 3000,
      user_id: leelavathi.id,
      category_id: Category.all.find_by(title: "Andhra Pradesh").id,
      status: "Active"
      )

    lentils = leelavathi.projects.create!(
      title: "Buy Lentil Seeds",
      description: "My family is looking to buy a large quantity of lentil seed and the associated materials needed to plant five additional acres to farm. We would like to grow additional crops to sell at the nearby city.",
      image: "http://www.releaseinternational.org/wp-content/uploads/2013/05/indian_water_buffalo.jpg",
      goal_amount: 1000,
      user_id: leelavathi.id,
      category_id: Category.all.find_by(title: "Andhra Pradesh").id,
      status: "Active"
      )

    rickshaw = gopal.projects.create!(
      title: "Buy a Rickshaw",
      description: "I am looking to buy one rickshaw, to build a driving business in our local city and help my support my family of 12.",
      image: "http://www.releaseinternational.org/wp-content/uploads/2013/05/indian_water_buffalo.jpg",
      goal_amount: 2000,
      user_id: gopal.id,
      category_id: Category.all.find_by(title: "Gujarat").id,
      status: "Active"
      )

    buffalo.loans.create( user_id: jeff.id,
                          amount: 2700)
    lentils.loans.create( user_id: jeff.id,
                          amount: 700)
    rickshaw.loans.create(user_id: josh.id,
                          amount: 1600)

    jorge = User.create!(
      first_name: "Jorge",
      last_name: "Téllez",
      username: "jorge@turing.io",
      password: "password",
      bio: "I like to make jokes and boss people around. Father of one.",
      image: "https://pbs.twimg.com/profile_images/545426238173888512/2cfTVpu0.jpeg"
     )
    jorge.roles << @admin

    puts "Sample seed display data created for lenders Jeff and Josh, borrowers Andrew, Leelavathi and Gopal, three projects and admin Jorge."
  end

end

Seed.start
