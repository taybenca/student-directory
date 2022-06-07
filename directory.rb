@students = []
def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu()
    process(gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      @students = input_students()
    when "2"
      show_students()
    when "9"
      exit
    else 
      puts "I don't know what you meant, try again"
    end
end

def input_students
  puts "Please enter the names of the student and hit return."
  puts "To finish, just hit return twice"
  name = gets.chomp
  while !name.empty? do
    @students << {name: name, cohort: :november, hobbies: :empty, country_of_birth: :empty, height: :empty}
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    name = gets.chomp
  end
  @students
end

def show_students
  print_header()
  print_students_list(@students)
  print_footer(@students)
end

def print_header
    puts "The students of Villains Academy"
    puts "-------------"
end

def print_students_list(students)
  if @students.length >=1
    @students.each_with_index do |student, index|
      puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"#.center(50)
    end
  end
end
  
def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

interactive_menu

