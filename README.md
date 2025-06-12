# Blockchain-Based Maintenance Work Order Management System

A comprehensive blockchain-based system for managing maintenance work orders, built on the Stacks blockchain using Clarity smart contracts.

## Overview

This system provides a decentralized solution for maintenance management with the following key features:

- **Provider Verification**: Validates and manages maintenance service providers
- **Work Order Management**: Handles the complete lifecycle of maintenance work orders
- **Scheduling Optimization**: Optimizes maintenance scheduling based on availability and priority
- **Parts Coordination**: Manages inventory and coordination of maintenance parts
- **Performance Measurement**: Tracks and measures maintenance performance metrics

## Architecture

The system consists of five main smart contracts:

### 1. Maintenance Provider Contract (\`maintenance-provider.clar\`)
- Provider registration and verification
- Certification management
- Provider status tracking
- Specialization categorization

### 2. Work Order Contract (\`work-order.clar\`)
- Work order creation and management
- Status tracking (Created → Assigned → In Progress → Completed)
- Priority management (Low, Medium, High, Critical)
- Cost estimation and tracking

### 3. Scheduling Optimizer Contract (\`scheduling-optimizer.clar\`)
- Provider availability management
- Time slot scheduling
- Conflict prevention
- Capacity optimization

### 4. Parts Coordination Contract (\`parts-coordination.clar\`)
- Inventory management
- Parts reservation system
- Stock tracking
- Supplier information

### 5. Performance Measurement Contract (\`performance-measurement.clar\`)
- Work order rating system
- Provider performance metrics
- Quality tracking
- Feedback management

## Key Features

### Provider Management
- Secure provider registration
- Multi-level verification process
- Certification tracking with expiry dates
- Specialization-based categorization
- Performance-based rating system

### Work Order Lifecycle
1. **Creation**: Customers create work orders with details and priority
2. **Assignment**: Work orders are assigned to verified providers
3. **Execution**: Providers start and complete work
4. **Rating**: Customers rate completed work
5. **Analytics**: Performance metrics are automatically updated

### Smart Scheduling
- Time slot management (24-hour slots per day)
- Provider availability tracking
- Conflict detection and prevention
- Capacity optimization

### Inventory Management
- Real-time stock tracking
- Automated reservation system
- Supplier information management
- Cost calculation

### Performance Analytics
- Multi-dimensional rating system (Quality, Timeliness, Communication)
- Automated performance metric calculation
- Historical performance tracking
- Provider ranking system

## Contract Functions

### Maintenance Provider Contract
- \`register-provider\`: Register a new maintenance provider
- \`verify-provider\`: Verify a provider (admin only)
- \`add-certification\`: Add certification for a provider
- \`get-provider\`: Get provider details
- \`is-provider-verified\`: Check verification status

### Work Order Contract
- \`create-work-order\`: Create a new work order
- \`assign-work-order\`: Assign work order to provider
- \`start-work\`: Start work on assigned order
- \`complete-work-order\`: Mark work order as completed
- \`get-work-order\`: Get work order details

### Scheduling Optimizer Contract
- \`schedule-work-order\`: Schedule a work order
- \`set-provider-availability\`: Set provider availability
- \`get-provider-schedule\`: Get provider schedule
- \`is-slot-available\`: Check slot availability

### Parts Coordination Contract
- \`add-part\`: Add part to inventory
- \`reserve-parts\`: Reserve parts for work order
- \`update-stock\`: Update stock quantity
- \`get-part\`: Get part information
- \`check-stock\`: Check stock availability

### Performance Measurement Contract
- \`rate-work-order\`: Rate completed work order
- \`record-metric\`: Record performance metric
- \`get-provider-performance\`: Get provider performance
- \`get-order-rating\`: Get order rating

## Error Codes

### Maintenance Provider Contract (100-199)
- \`100\`: Unauthorized access
- \`101\`: Provider already exists
- \`102\`: Provider not found
- \`103\`: Invalid status

### Work Order Contract (200-299)
- \`200\`: Unauthorized access
- \`201\`: Order not found
- \`202\`: Invalid status transition
- \`203\`: Provider not verified

### Scheduling Optimizer Contract (300-399)
- \`300\`: Unauthorized access
- \`301\`: Schedule not found
- \`302\`: Invalid time slot
- \`303\`: Time slot occupied

### Parts Coordination Contract (400-499)
- \`400\`: Unauthorized access
- \`401\`: Part not found
- \`402\`: Insufficient stock
- \`403\`: Invalid quantity

### Performance Measurement Contract (500-599)
- \`500\`: Unauthorized access
- \`501\`: Invalid rating value
- \`502\`: Record not found

## Testing

The system includes comprehensive test suites for all contracts using Vitest:

\`\`\`bash
npm test
\`\`\`

Test files:
- \`tests/maintenance-provider.test.js\`
- \`tests/work-order.test.js\`
- \`tests/scheduling-optimizer.test.js\`
- \`tests/parts-coordination.test.js\`
- \`tests/performance-measurement.test.js\`

## Deployment

1. Deploy contracts to Stacks blockchain
2. Verify contract deployment
3. Initialize system parameters
4. Register initial providers
5. Set up monitoring and analytics

## Security Considerations

- All critical functions include authorization checks
- Input validation on all user inputs
- State consistency maintained across contracts
- Error handling for edge cases
- Access control for administrative functions

## Future Enhancements

- Integration with IoT sensors for automated work order creation
- Machine learning for predictive maintenance scheduling
- Multi-signature approval for high-value work orders
- Integration with payment systems
- Mobile application interface
- Real-time notifications system

## License

This project is licensed under the MIT License.
