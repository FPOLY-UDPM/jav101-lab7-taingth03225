package poly.servlet;

import org.apache.commons.beanutils.BeanUtils;
import poly.dao.DepartmentDAO;
import poly.dao.DepartmentDAOImpl;
import poly.entity.Department;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

@WebServlet({
        "/department/index",
        "/department/edit/*",
        "/department/create",
        "/department/update",
        "/department/delete",
        "/department/reset"
})
public class DepartmentServlet extends HttpServlet{
        @Override
        protected void service(HttpServletRequest req, HttpServletResponse resp) throws
                ServletException, IOException {
            Department form = new Department();
            try {
                BeanUtils.populate(form, req.getParameterMap());
            } catch (IllegalAccessException | InvocationTargetException e) {
                e.printStackTrace();
            }
            DepartmentDAO dao = new DepartmentDAOImpl();
            String path = req.getServletPath();
            if (path.contains("edit")) {
                String id = req.getPathInfo().substring(1);
                form = dao.findById(id);
            } else if (path.contains("create")) {
                dao.create(form);
                form = new Department();
            } else if (path.contains("update")) {
                dao.update(form);
            } else if (path.contains("delete")) {
                dao.deleteById(form.getId());
                form = new Department();
            } else {
                form = new Department();
            }
            req.setAttribute("item", form);
            List<Department> list = dao.findAll();
            req.setAttribute("list", list);
            req.getRequestDispatcher("/views/department.jsp").forward(req, resp);
        }
    }


