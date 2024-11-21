# Fetch-Coding-Challenge
This is a public repository to submit Analytics Engineer - Coding Challenge
I'm using PostgreSQL as my SQL dialect.

# Step 1: Diagram the Structured Relational Data Model

The goal is to transform the provided unstructured JSON data into a structured relational data model with clearly defined entities and relationships.

## Entities and Tables

### Users Table
This table stores information about the users who scanned receipts.

- **Fields**:
  - `user_id` (Primary Key): Unique identifier for the user
  - `state`: State abbreviation of the user
  - `created_date`: Date the user account was created
  - `last_login`: Timestamp of the user's most recent login
  - `role`: Constant value, set to 'CONSUMER'
  - `active`: Boolean flag indicating if the user is active

---

### Receipts Table
This table represents the data from scanned receipts.

- **Fields**:
  - `receipt_id` (Primary Key): Unique identifier for the receipt
  - `user_id` (Foreign Key): Links to the `Users` table
  - `bonus_points_earned`: Number of bonus points awarded
  - `bonus_points_reason`: Reason for awarding bonus points
  - `create_date`: Timestamp when the receipt event was created
  - `date_scanned`: Date the receipt was scanned
  - `finished_date`: Timestamp when receipt processing was completed
  - `modify_date`: Timestamp when the receipt was last modified
  - `points_awarded_date`: Date when points were awarded
  - `points_earned`: Total points earned for the receipt
  - `purchase_date`: Date of the purchase
  - `purchased_item_count`: Total number of items on the receipt
  - `rewards_receipt_status`: Status of the receipt processing ('Accepted', 'Rejected', etc.)
  - `total_spent`: Total amount spent on the receipt

---

### Brands Table
This table contains details about brands associated with purchased items.

- **Fields**:
  - `brand_id` (Primary Key): Unique identifier for the brand
  - `barcode`: Barcode for the brand's products
  - `brand_code`: Code corresponding to the brand in partner product files
  - `category`: Category name of the brand's products
  - `category_code`: Code representing the category
  - `cpg`: Reference to the Consumer Packaged Goods (CPG) collection
  - `top_brand`: Boolean flag indicating if the brand is a 'top brand'
  - `brand_name`: Name of the brand

---

### ReceiptItems Table (Bridge Table)
This table manages the many-to-many relationship between `Receipts` and `Brands` while providing detailed information about items purchased.

- **Fields**:
  - `id` (Primary Key): Unique identifier for the ReceiptItems table
  - `receipt_id` (Foreign Key): Links to the `Receipts` table
  - `barcode` : Barcode of the item, useful for product identification and lookup.
  - `brand_id` (Foreign Key): Links to the `Brands` table
  - `description`: Description of the purchased item
  - `quantity`: Quantity of the purchased item
  - `price`: Price per unit of the item
  - `total_price`: Total price for this item (quantity * price)

---

## Relationships

- **Users and Receipts**: One-to-Many (A user can scan multiple receipts)
- **Receipts and ReceiptItems**: One-to-Many (One receipt can have many receipt items, since a single receipt typically includes multiple purchased items). Each row in the ReceiptItems table represents a single item on a specific receipt.
- **Receipts and Brands**: Many-to-Many (Managed through the `ReceiptItems` table)

---

## ER Diagram

Please check ERD folder as a representation of the relationships between the tables

