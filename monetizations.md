# Monetization Ideas

## Premium AI Features (Paywall)

Gate AI-powered features behind a subscription to offset API costs and generate revenue.

### Free Tier
- Browse restaurants
- View aggregated Edible Scores
- See basic info (hours, location, phone)

### Premium Tier (~$4.99/month)
- **AI Blurbs** — Auto-generated "Virtual Sous Chef" reviews
- **Ask Questions** — Chat with AI about a restaurant ("Is this good for a date?", "What's their best dish?")
- **Personalized Recommendations** — "Find me a quiet Italian spot under $50 in Brooklyn"
- **Compare Restaurants** — "How does Carbone compare to Lilia?"

---

## Unit Economics

| Metric | Estimate |
|--------|----------|
| Cost per AI request | ~$0.001-0.002 |
| Requests per premium user/month | ~50 |
| Cost per premium user/month | ~$0.07 |
| Subscription price | $4.99 |
| **Gross margin** | **~98%** |

---

## Technical Requirements

1. **Authentication** — User accounts (Sign in with Apple, email/password)
2. **Subscription management** — RevenueCat or StoreKit 2
3. **Entitlement checks** — Gate AI features behind subscription status
4. **Usage tracking** — Optional: limit requests per month if needed

---

## Future Considerations

- **Caching** — Store generated blurbs per restaurant to reduce redundant API calls
- **Tiered plans** — Basic ($2.99) vs Pro ($6.99) with different request limits
- **Annual discount** — $39.99/year (~33% off)
