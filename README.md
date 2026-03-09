# Randomized Welcome Banner

Extends Discourse's core welcome banner to display a different message on each page load. Supports separate message pools for new members, returning users, and anonymous visitors.

## Configuration

Add messages for each user type in your theme settings, one per line:

**New Members**:
```
Welcome to our community!
Great to have you here!
Your journey begins now!
```

**Logged In Members**:
```
Welcome back!
Good to see you again!
Ready to explore?
```

**Anonymous Visitors**:
```
Welcome!
Join our community today!
Discover amazing discussions!
```

Leave a pool empty to use the core banner's default message for that user type.
