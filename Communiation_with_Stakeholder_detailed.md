# Communicate with Stakeholders

## Email to Stakeholders

**Subject:** Data Quality and Model Optimization Recommendations  

Hi Team,  

After reviewing the provided data, I’ve structured it into a relational model and identified several data quality issues that may impact our analysis and downstream calculations. Here's an overview:  


### Key Questions About the Data
1. **What is the expected behavior for `user_id` alignment across collections?**  
   - Some `user_id` values in `Receipts` do not correspond to valid entries in the `Users` collection. Should all receipts be tied to existing users, or are orphaned receipts expected?  

2. **How should we handle date fields that appear out of sequence or missing?**  
   - For example, some `purchaseDate` values occur after `dateScanned`, and others are missing entirely. Can we establish rules for how these fields should interact?  

3. **What are the valid statuses for `rewardsReceiptStatus`?**  
   - We encountered entries with `"FLAGGED"`, but it’s unclear how these statuses should be treated. Are they part of the active data pipeline, or do they require manual intervention?  

---

### How the Issues Were Identified
I performed a systematic exploration of the data using validation scripts and logic-based checks. Here’s a summary of how the issues surfaced:  
- **Misaligned `user_id`:** Cross-referenced `user_id` values in `Receipts` against `Users` and found unmatched entries.  
- **Date Inconsistencies:** Parsed millisecond timestamps and identified cases where date sequences (e.g., `purchaseDate`, `dateScanned`, `finishedDate`) didn’t align logically.  
- **Data Type Mismatches:** Found numeric fields like `pointsEarned` and `totalSpent` stored as strings, which can cause calculation errors.  
- **Problematic Receipts:** Detected receipts with zero `purchasedItemCount` or flagged items (`needsFetchReview: true`).  
- **Redundant Entries:** Observed duplicate items within single receipts (e.g., identical Miller Lite entries).  
- **Incomplete Item Information:** Many items had placeholder descriptions like `"ITEM NOT FOUND"`.  

---

### What I Need to Resolve These Issues
To address these challenges effectively, I need the following clarifications and input:  
1. **Business Definitions and Data Expectations:**  
   - Should all receipts be linked to a valid user?  
   - Can placeholder descriptions like `"ITEM NOT FOUND"` be automatically enriched or flagged for manual review?  

2. **Validation Rules:**  
   - What are the expected relationships between date fields? For example, should `purchaseDate` always precede `dateScanned`?  
   - Are receipts with zero `purchasedItemCount` valid, or should they be excluded?  

3. **Standardized Data Types:**  
   - Can we enforce strict typecasting for fields like `pointsEarned` and `totalSpent` during ingestion?  

---

### Additional Information Needed to Optimize Data Assets
- **Product Metadata:**  
  - Access to external product databases or lookup services would help enrich missing item descriptions and attributes.  
- **Point Awarding Documentation:**  
  - Clear rules for how points are awarded or withheld (e.g., `pointsNotAwardedReason`) will ensure consistent calculations.  

---

### Performance and Scaling Concerns
1. **Data Growth:**  
   - As the dataset grows, joins across large collections (e.g., `Receipts`, `Users`, and `Brands`) could slow down queries. Pre-aggregating commonly used metrics (e.g., monthly spend by brand) will mitigate this.  

2. **Indexing:**  
   - Adding indexes on frequently used fields like `receipt_id`, `user_id`, and `brand_id` can improve query performance.  

3. **Validation at Ingestion:**  
   - Enforcing data integrity checks during ingestion will reduce downstream errors and inconsistencies. For instance, validating date sequences and ensuring numeric fields are correctly typed at the source.  

---

### Proposed Next Steps
1. Collaborate to define validation rules and business logic for critical fields and relationships.  
2. Implement automated checks for duplicate items and redundant records.  
3. Integrate enrichment processes for placeholder values and incomplete item descriptions.  
4. Develop and document standard operating procedures for handling flagged receipts and point awarding logic.  

By addressing these issues systematically, we can ensure that our data is robust, scalable, and ready to support key business decisions. Let me know if we can set up a session to discuss these insights and prioritize solutions.  

Best regards,  
Dapeng Ding 