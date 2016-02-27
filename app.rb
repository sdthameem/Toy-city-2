start

def start
	setup_files
	create_report
end

def setup_files
    require 'json'
	path = File.join(File.dirname(__FILE__), '../data/products.json')
	file = File.read(path)
	$products_hash = JSON.parse(file)
	$report_file = File.new("report.txt", "w+")
end

def create_report
	print_sales_report_art
	print_todays_date
	loop_products_hash
	products_report
	brands_report
end

def print_sales_report_art
    puts"  #####                                 ######                                   " 
    puts" #     #   ##   #      ######  ####     #     # ###### #####   ####  #####  #####"
    puts" #        #  #  #      #      #         #     # #      #    # #    # #    #   #  "
    puts"  #####  #    # #      #####   ####     ######  #####  #    # #    # #    #   #  "
    puts"       # ###### #      #           #    #   #   #      #####  #    # #####    #  "
    puts" #     # #    # #      #      #    #    #    #  #      #      #    # #   #    #  "
    puts"  #####  #    # ###### ######  ####     #     # ###### #       ####  #    #   #  "
    puts"******************************************************************************** "            
end

def print_todays_date 
	# Print today's date
	puts "Date : #{Time.now.strftime("%m/%d/%Y")}"
end

def products_report
	print_products_in_art
    calculate_product_details
end

def brands_report
    print_brands_in_art
    calculate_brands_details
end    





# Print "Sales Report" in ascii art

# Print today's date

# Print "Products" in ascii art

# For each product in the data set:
	# Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	# Calculate and print the average price the toy sold for
	# Calculate and print the average discount (% or $) based off the average sales price

# Print "Brands" in ascii art

# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined
