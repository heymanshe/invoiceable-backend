# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all
Template.destroy_all
Industry.destroy_all

puts "Seeding users..."

User.create!([
  { name: "Alice Johnson", email: "alice@example.com", password: "password123" },
  { name: "Bob Smith", email: "bob@example.com", password: "securepass" },
  { name: "Charlie Brown", email: "charlie@example.com", password: "letmein123" },
  { name: "Ross Carpenter", email: "ross@example.com", password: "iamross" },
  { name: "Rachel Dylan", email: "rachel@example.com", password: "iamrachel" }
])

puts "Seeding industries..."

industries = [
  { name: "General" },
  { name: "Freelancer" },
  { name: "Technology" },
  { name: "Finance" },
  { name: "Healthcare" }
]

industry_records = industries.map { |industry| Industry.create!(industry) }

puts "Seeding templates..."

templates = [
  { name: "Basic Invoice", industry_id: industry_records[0].id, preview_url: "https://example.com/previews/basic_invoice.jpg" },
  { name: "Simple Estimate", industry_id: industry_records[0].id, preview_url: "https://example.com/previews/simple_estimate.jpg" },
  { name: "Minimal", industry_id: industry_records[0].id, preview_url: "https://example.com/previews/minimal.jpg" },

  { name: "Project Quote", industry_id: industry_records[1].id, preview_url: "https://example.com/previews/project_quote.jpg" },
  { name: "Freelancer", industry_id: industry_records[1].id, preview_url: "https://example.com/previews/freelancer.jpg" },

  { name: "Modern", industry_id: industry_records[2].id, preview_url: "https://example.com/previews/modern.jpg" },
  { name: "Software Development Invoice", industry_id: industry_records[2].id, preview_url: "https://example.com/previews/software_invoice.jpg" },
  { name: "IT Service Quote", industry_id: industry_records[2].id, preview_url: "https://example.com/previews/it_service_quote.jpg" },

  { name: "Professional", industry_id: industry_records[3].id, preview_url: "https://example.com/previews/professional.jpg" },
  { name: "Financial Report", industry_id: industry_records[3].id, preview_url: "https://example.com/previews/financial_report.jpg" },
  { name: "Investment Summary", industry_id: industry_records[3].id, preview_url: "https://example.com/previews/investment_summary.jpg" },

  { name: "Medical Bill", industry_id: industry_records[4].id, preview_url: "https://example.com/previews/medical_bill.jpg" },
  { name: "Patient Invoice", industry_id: industry_records[4].id, preview_url: "https://example.com/previews/patient_invoice.jpg" }
]

templates.each do |template|
  Template.create!(template)
end

puts "Seeding completed successfully!"
