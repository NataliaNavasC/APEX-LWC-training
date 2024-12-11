public with sharing class CalculatorController {

    @AuraEnabled(cacheable=true)
    public static Decimal calculate(String expression) {
        try {
            // Use a safe parser for expression evaluation if needed
            Decimal result = (Decimal) evalExpression(expression);
            system.debug('Result calculated successfully');
            return result;
        } catch (Exception e) {
            throw new AuraHandledException('Invalid expression: ' + e.getMessage());
        }
    }

    private static Decimal evalExpression(String expression){
        // Assuming the following format 1+2
        String[] parts;
        if(expression.contains('+')){
            parts = expression.split('\\+');
            return Decimal.valueOf(parts[0].trim()) + Decimal.valueOf(parts[1].trim());
        } else if(expression.contains('-')){
            parts = expression.split('-');
            return Decimal.valueOf(parts[0].trim()) - Decimal.valueOf(parts[1].trim());
        } else if(expression.contains('*')){
            parts = expression.split('\\*');
            return Decimal.valueOf(parts[0].trim()) * Decimal.valueOf(parts[1].trim());
        } else if(expression.contains('/')){
            parts = expression.split('/');
            Decimal  n1 = Decimal.valueOf(parts[0].trim());
            Decimal n2 = Decimal.valueOf(parts[1].trim());
            if(n2!=0){
                return n1/n2;
            }
            else{
                throw new AuraHandledException('Division by zero is not allowed.');
            }
        }
        else{
            throw new AuraHandledException('Unsupported operation or invalid format.');
        }
    }
}