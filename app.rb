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
	group_array=create_group_array
	fetch_group_array(group_array)
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

def create_group_array
	group_array= products_hash["items"].group_by {|name| name["brand"]}
	return group_array
end    

def fetch_group_array(group_array)
	group_array.each do |brand_name,brand_details|
# Initializing variables
        toys_in_stock = 0
        brand_revenue,brand_avg_price, brand_purchase_cnt = 0.0, 0.0, 0
        fetch_sub_group_array(brand_details)



# Fetching each value details in a brand and doing calculation
  brand_details.each do |brand_key_details|
    toys_in_stock = counter_sum(toys_in_stock,sum: brand_key_details["stock"])
  
    brand_key_details["purchases"]. each do |purchase_brand|
       brand_purchase_cnt = counter_sum(brand_purchase_cnt)
       brand_revenue += purchase_brand["price"] + purchase_brand["shipping"]
    end
#Calculating average price 
    brand_avg_price = calculate_avg_price(brand_revenue,brand_purchase_cnt)
  end

# Printing the required data for each brand
  print_products_report(brand_name,toys_in_stock, brand_avg_price,brand_revenue)
  puts brand_name
  puts "*********************************"
  puts "Toys in Stock: #{toys_in_stock}"
  puts "Average price: #{brand_avg_price.round(2)}"
  puts "Total Revenue: #{brand_revenue.round(2)} \n\n"
end

def counter_sum(counter,options = {})
	if options[:sum]
		counter += sum
		return counter
	else
		counter += 1
		return counter
	end
end

def calculate_avg_price(revenue,count)
	avg_price = revenue / count
	return avg_price
end

def print_products_report(options = {})
	puts name1








def products_report
	print_products_in_art
    calculate_product_details
end

def print_products_in_art
	puts "                     _            _       "
    puts "                    | |          | |      "
    puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
    puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
    puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
    puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
    puts "| |                                       "
    puts "|_|                                       "
end


def brands_report
    print_brands_in_art
    calculate_brands_details
end    

def print_brands_in_art
    puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts
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
