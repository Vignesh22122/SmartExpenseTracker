package com.expensetracker.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;

public class ExpenseInsightService {

    public List<String> generateInsights(BigDecimal totalSpent, BigDecimal budget, String topCategory, BigDecimal topCategoryAmount) {
        List<String> insights = new ArrayList<>();

        if (budget.compareTo(BigDecimal.ZERO) > 0) {
            BigDecimal percentage = totalSpent.multiply(new BigDecimal("100")).divide(budget, 2, RoundingMode.HALF_UP);
            
            if (percentage.compareTo(new BigDecimal("100")) > 0) {
                insights.add("CRITICAL: You have exceeded your monthly budget by " + percentage.subtract(new BigDecimal("100")) + "%!");
            } else if (percentage.compareTo(new BigDecimal("80")) >= 0) {
                insights.add("WARNING: You have consumed " + percentage + "% of your monthly budget allowance.");
            } else {
                insights.add("EXCELLENT: You are within budget limits with " + (new BigDecimal("100").subtract(percentage)) + "% remaining.");
            }
        }

        if (topCategory != null && topCategoryAmount != null) {
            insights.add("TOP CATEGORY: " + topCategory + " accounts for highest expenditure of ₹" + topCategoryAmount);
        }

        return insights;
    }
}