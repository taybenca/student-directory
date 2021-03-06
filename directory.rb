@students = []
def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu()
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      @students = input_students()
    when "2"
      show_students()
    when "3"
      save_students()
    when "4"
      load_students()
    when "9"
      exit
    else 
      puts "I don't know what you meant, try again"
    end
end

def input_students
  puts "Please enter the names of the student and hit return."
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    add_students_into_array(name, :november)
    if @students.count == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    name = STDIN.gets.chomp
  end
  @students
end

def show_students
  print_header()
  print_students_list(@students)
  print_footer(@students)
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    add_students_into_array(name, cohort.to_sym)
  end
  file.close
  puts @students
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
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

def add_students_into_array(name, cohort)
  @students << {name: name, cohort: cohort}
end

try_load_students()
interactive_menu()

