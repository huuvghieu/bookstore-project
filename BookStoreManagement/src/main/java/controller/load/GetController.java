/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller.load;

import dao.BookDAO;
import dao.CategoryDAO;
import dao.PromotionDAO;
import dao.PublisherDAO;
import dto.BookDTO;
import dto.CategoryDTO;
import dto.PromotionDTO;
import dto.PublisherDTO;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Administrator
 */
//Quốc Thịnh >>>>>>>>>>
public class GetController extends HttpServlet {

    private static final String ERROR = "WEB-INF/JSP/HomePage/error.jsp";
    private static final String SUCCESS = "WEB-INF/JSP/HomePage/homePage.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int index = 1;
            try {
                index = Integer.parseInt(request.getParameter("index"));
            } catch (Exception e) {
                index = 1;
            }
            HttpSession session = request.getSession();
            LocalDate localDate = LocalDate.now();
            LocalDate dateEnd = LocalDate.now();
            BookDAO bookDao = new BookDAO();
            CategoryDAO cateDao = new CategoryDAO();
            PublisherDAO pubDao = new PublisherDAO();
            PromotionDAO proDao = new PromotionDAO();
            List<PromotionDTO> listPro = proDao.loadAvailablePromotion("1");
            for (PromotionDTO promotionDTO : listPro) {
                dateEnd = LocalDate.parse(promotionDTO.getDateEnd());
                if (dateEnd.isBefore(localDate)) {
                    promotionDTO.setStatus("0");
                    proDao.updatePromotion(promotionDTO);
                }
            }
            List<CategoryDTO> listCate = cateDao.getListCategory("1"); //Lấy tất cả thể loại
            List<PublisherDTO> listPub = pubDao.getListPublisher("1"); //Lấy tất cả NXB
            List<BookDTO> listBook = bookDao.getListBook(index, "1"); //Lấy thông tin sách cho phân trang số 1
            int count = bookDao.countBook("1");//Đếm tổng số lượng sản phẩm trong database
            url = SUCCESS;
            if (listBook.size() > 0) {
                session.setAttribute("PROMOTION", proDao.loadAvailablePromotion("1"));
                session.setAttribute("LIST_BOOK", listBook);
                session.setAttribute("LIST_PUB", listPub);
                session.setAttribute("LIST_CATE", listCate);
                session.setAttribute("COUNT_BOOK", count);
                session.setAttribute("LIST_BOOK_SORT", bookDao.getAllBook("1"));
                request.setAttribute("CONTROLLER", "GetController?");
            }

        } catch (Exception e) {
            log("ERROR AT GETCONTROLLER : " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
//<<<<<<<<<<
