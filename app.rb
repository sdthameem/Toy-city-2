
##**************Printing generic data section********************************************
def print_sales_report_art
    $report_file.puts"\n********************************************************************************"            
    $report_file.puts"  #####                                 ######                                     " 
    $report_file.puts" #     #   ##   #      ######  ####     #     # ###### #####   ####  #####  #####  "
    $report_file.puts" #        #  #  #      #      #         #     # #      #    # #    # #    #   #    "
    $report_file.puts"  #####  #    # #      #####   ####     ######  #####  #    # #    # #    #   #    "
    $report_file.puts"       # ###### #      #           #    #   #   #      #####  #    # #####    #    "
    $report_file.puts" #     # #    # #      #      #    #    #    #  #      #      #    # #   #    #    "
    $report_file.puts"  #####  #    # ###### ######  ####     #     # ###### #       ####  #    #   #    "
    $report_file.puts"********************************************************************************\n "            
end

def print_todays_date 
	# Print today's date
	$report_file.puts "Date : #{Time.now.strftime("%m/%d/%Y")}"
end

def print_products_in_art
	$report_file.puts "                     _            _       "
    $report_file.puts "                    | |          | |      "
    $report_file.puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
    $report_file.puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
    $report_file.puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
    $report_file.puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
    $report_file.puts "| |                                       "
    $report_file.puts "|_|                                       \n\n"
end

def print_brands_in_art
    $report_file.puts " _                         _     "
    $report_file.puts "| |                       | |    "
    $report_file.puts "| |__  _ __ __ _ _ __   __| |___ "
    $report_file.puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
    $report_file.puts "| |_) | | | (_| | | | | (_| \\__ \\"
    $report_file.puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
    $report_file.puts
end

def print_products_report(toy_name,full_price,product_purchase_cnt,sales_sum,avg_price,avg_discount)
    $report_file.puts toy_name
    $report_file.puts "*********************************"
    $report_file.puts "Retail price     : #{full_price}"
    $report_file.puts "Product purchases: #{product_purchase_cnt}"
    $report_file.puts "Product Sales    : #{sales_sum}"
    $report_file.puts "Average price    : #{avg_price.round(2)}"
    $report_file.puts "Average Discount : $#{avg_discount.round(2)} \n\n"  
end


def temp_array_brand_report
    temp_array = [brand_name,toys_in_stock,brand_avg_price,brand_revenue]
    return temp_array
end

#def print_brands_report(brand_name,toys_in_stock, brand_avg_price,brand_revenue)
   
#   $report_file.puts brand_name
#   $report_file.puts "*********************************"
#   $report_file.puts "Toys in Stock: #{toys_in_stock}"
#   $report_file.puts "Average price: #{brand_avg_price.round(2)}"
#   $report_file.puts "Total Revenue: #{brand_revenue.round(2)} \n\n"
#end

##**************Reusable methods section-start********************************************

def increment_counter(counter)
    counter += 1
    return counter
end

def sum(options = {})
    if options[:sum] and options[:sum1] and options[:sum2]
        options[:sum] +=  options[:sum1] + options[:sum2]
        return options[:sum]
    end
    if options[:sum] and options[:sum1]
        options[:sum] +=  options[:sum1]
        return options[:sum]
    end
end

def calculate_avg_price(revenue,count)
    avg_price = revenue / count
    return avg_price
end

##**************Reusable methods section-end********************************************

##**************Calculate reveue and count for products and brand-start********************************************

def get_product_sales_count(toy_name,sales_sum,product_purchase_cnt)
	toy_name["purchases"].each do |purchase_num|
        sales_sum = sum(sum: purchase_num["price"] , sum1: purchase_num["shipping"] , sum2: sales_sum)
        product_purchase_cnt =  increment_counter(product_purchase_cnt)
    end
    return sales_sum,product_purchase_cnt
end

def get_brand_revenue_count(brand_key_details,brand_revenue,brand_purchase_cnt)
	brand_key_details["purchases"].each do |purchase_brand|
       brand_purchase_cnt = increment_counter(brand_purchase_cnt)
       brand_revenue = sum(sum: brand_revenue , sum1: purchase_brand["price"] , sum2: purchase_brand["shipping"] )
    end
    return brand_revenue , brand_purchase_cnt
end

##**************Calculate reveue and count for products and brand-end********************************************

##**************Main method for Products and Brands-start********************************************

def brands_report(brand_name,brand_details)
# Initializing variables
    toys_in_stock = 0
    brand_revenue,brand_avg_price, brand_purchase_cnt = 0.0, 0.0, 0
# Fetching each value details in a brand and doing calculation
  brand_details.each do |brand_key_details|     
    toys_in_stock = sum(sum: toys_in_stock, sum1: brand_key_details["stock"])
    brand_revenue , brand_purchase_cnt = get_brand_revenue_count(brand_key_details,brand_revenue,brand_purchase_cnt)
#Calculating average price 
    brand_avg_price = calculate_avg_price(brand_revenue,brand_purchase_cnt)
  end
# Printing the required data for each brand
#  print_brands_report(brand_name,toys_in_stock, brand_avg_price,brand_revenue)
end

def products_report(product_details)
    product_details.each do |toy_name|

# Initializing variables
        avg_discount = 0.0

# Fetching details of purchases for each product 
        sales_sum,product_purchase_cnt = get_product_sales_count(toy_name,sales_sum = 0.0 ,product_purchase_cnt =0)

# Calculating average price
        avg_price = calculate_avg_price(sales_sum,product_purchase_cnt)

# For calculating the average discount , converting the string data type full-price to float data type
        avg_discount = toy_name["full-price"].to_f - avg_price

# Printing the required data for each product
        print_products_report(toy_name["title"],toy_name["full-price"],product_purchase_cnt,sales_sum,avg_price,avg_discount)
    end
end
##**************Main method for Products and Brands-end********************************************

###Creating a new array with group by brands and then fetching each hash value pair-start
def create_group_array
    group_array= $products_hash["items"].group_by {|name| name["brand"]}
    return group_array
end 

def use_group_array(group_array)
	group_array.each_with_index do |(name,details),index|
        if index == 0
        	print_products_in_art
        end
        products_report(details)
        if index == 0
        	print_brands_in_art
        end
        brands_report(name,details)
    end
end
###Creating a new array with group by brands and then fetching each hash value pair-end

###Print main heading and call methods to get Products and Brand details
def create_report
	print_sales_report_art
	print_todays_date
	group_array=create_group_array
	use_group_array(group_array)
end

###Parsing file method
def setup_files
    require 'json'
	path = File.join(File.dirname(__FILE__), '../data/products.json')
	file = File.read(path)
	$products_hash = JSON.parse(file)
    $report_file = File.new("report.txt", "w+")
end

##Start method
def start
	setup_files
	create_report
end

start


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