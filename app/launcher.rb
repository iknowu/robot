require '../lib/robot'
puts "Start to control a robot\n"
puts "Please select input type\n1:standard\n2:file\n"
r=Robot.new
case gets.strip
  when '1'
    puts "Please give your instructions.\n"
    command=''
    until command.eql?('station')
      command = gets.strip
      r.execute(command.to_s)
    end
  when '2'
    data_path=File.expand_path('../../spec/test_data', __FILE__)
    puts "Please type in the test file name under #{data_path}\n"
    begin
      f = File.open(data_path+'/'+gets.strip, "r")
      f.each_line do |line|
        puts line
        r.execute(line.strip)
      end
      f.close
    rescue
      puts "can not open file\n"
    end
end

