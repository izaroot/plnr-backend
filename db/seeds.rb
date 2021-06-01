puts "Deleting seeds! 🗑"
Task.destroy_all
User.destroy_all
UserTask.destroy_all

puts "Creating seeds! 🌸"

tasks = [
    {
        name: "Mow the Lawn",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Chore"
    },
    {
        name: "Read a Book",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Leisure"
    },
    {
        name: "Write a Poem",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Productivity"
    },
    {
        name: "Go for a Run",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Exercise"
    },
    {
        name: "Go for a Walk",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Exercise"
    },
    {
        name: "Eat",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Self Care"
    },
    {
        name: "Bake Cookies",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Productivity"
    },
    {
        name: "Do Laundry",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Chore"
    },
    {
        name: "Go to the Bank",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Productivity"
    },
    {
        name: "Wash the Dishes",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Chore"
    },
    {
        name: "Take a Shower",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Self Care"
    },
    {
        name: "Go Bowling",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Leisure"
    },
    {
        name: "Go on a Hike",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Exercise"
    },
    {
        name: "Go Grocery Shopping",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Chore"
    },
    {
        name: "Commit a crime",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Leisure"
    },
    {
        name: "Look for Dad",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Self Care"
    },
    {
        name: "Cry",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Self Care"
    },
    {
        name: "Take a nap",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Leisure"
    },
    {
        name: "Go Swimming",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Exercise"
    },
    {
        name: "Clean Up",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Chore"
    },
    {
        name: "Call Mom",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Productivity"
    },
    {
        name: "Call Dad",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Productivity"
    },
    {
        name: "Get a Haircut",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Self Care"
    },
    {
        name: "Get a Manicure",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Leisure"
    },
    {
        name: "Get a Pedicure",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Leisure"
    },
    {
        name: "Fix Car",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Productivity"
    },
    {
        name: "Get vaccinated",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Self Care"
    },
    {
        name: "Get a Coffee",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Leisure"
    },
    {
        name: "Make Dinner",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Chore"
    },
    {
        name: "Ruin Dinner",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Productivity"
    },
    {
        name: "Go on a Date",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Leisure"
    },
    {
        name: "Build a House",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Productivity"
    },
    {
        name: "Feed Dog",
        description: Faker::TvShows::TheITCrowd.quote,
        category: "Chore"
    }
]

tasks.each do |task|
    Task.create(name: task[:name], description: task[:description], category: task[:category])    
end

10.times do
    User.create(
        name: Faker::FunnyName.name,
        profile_img: Faker::SlackEmoji.people,
        birthdate: Faker::Date.birthday(min_age: 18, max_age: 65), 
        username: "#{Faker::Name.first_name}#{Faker::Number.number(digits: 2)}",
        password: "#{Faker::Verb.base}#{Faker::Number.number(digits: 2)}",
        )
end

50.times do
    UserTask.create(
        start_time: Faker::Time.between(from: DateTime.now - 3, to: DateTime.now, format: :default),
        end_time: Faker::Time.forward(days: 1, format: :default),
        user_id: User.ids.sample,
        task_id: Task.ids.sample,
        is_complete: rand < 0.5,
        priority: rand(3)
    )
end

puts "Done creating seeds ✅"