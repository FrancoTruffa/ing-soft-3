package payroll;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class EmployeeTest {

    @Test
    public void TestBasic() {
    	Employee franco = new Employee("Franco", "Truffa", "test");
    	assertEquals(franco.getName(), "Franco Truffa");
    }

    @Test
    public void TestLastName() {
    	Employee profesor = new Employee("Alexis", "Ferrucci", "trabajo");
    	assertEquals(profesor.getLastName(), "Ferrucci");
    }
}