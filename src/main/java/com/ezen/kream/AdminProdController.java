package com.ezen.kream;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ezen.kream.dto.AdminAllDTO;
import com.ezen.kream.dto.AdminProdDTO;
import com.ezen.kream.dto.PickCateListDTO;
import com.ezen.kream.dto.PickProdListDTO;
import com.ezen.kream.dto.ProdCateDTO;
import com.ezen.kream.dto.ProdImgDTO;
import com.ezen.kream.dto.SalesAllDTO;
import com.ezen.kream.service.AdminProdMapper;
import com.ezen.kream.service.UserAlarmMapper;
import com.ezen.kream.service.UserShopMapper;

@Controller
public class AdminProdController {
   @Autowired
   private AdminProdMapper adminProdMapper;
   @Autowired
   private UserShopMapper userShopMapper;
   @Autowired
   private UserAlarmMapper userAlarmMapper;
   @Resource(name = "uploadPath")
   private String upPath;
   private String[] shoe_size = { "220", "225", "230", "235", "240", "245", "250", "255", "260", "265", "270", "275",
         "280", "290", "300" };
   private String[] cloth_size = { "XS", "S", "M", "L", "XL", "XXL" };
   private String[] gender = { "M", "F", "All" };

   @RequestMapping("/admin.admin")
   public String admin_main() {
      return "admin/product/adminMain";
   }

   // 관리자 상품 입력 폼
   @RequestMapping(value = "/prodInput.admin", method = RequestMethod.GET)
   public String admin_prodInput(ProdCateDTO dto, HttpServletRequest req) {
      List<String> brandList = adminProdMapper.brandList();
      req.setAttribute("brandList2", brandList);
      List<String> brand_kr_list = adminProdMapper.brand_kr_list();
      List<String> cate_typeList = adminProdMapper.cate_typeList();
      List<String> cate_subTypeList = adminProdMapper.cate_subtypeList();
      List<String> cate_kr_subtypeList = adminProdMapper.cate_kr_subtypeList();
      List<String> cate_kr_typeList = adminProdMapper.cate_kr_typeList();
      req.setAttribute("brand_kr_list", brand_kr_list);
      req.setAttribute("cate_typeList", cate_typeList);
      req.setAttribute("cate_subTypeList", cate_subTypeList);
      req.setAttribute("cate_kr_subtypeList", cate_kr_subtypeList);
      req.setAttribute("cate_kr_typeList", cate_kr_typeList);
      return "admin/product/prodForm";
   }

   @RequestMapping(value = "/prodEdit.admin", method = RequestMethod.GET)
   public String admin_edit(@RequestParam int prod_num, HttpServletRequest req) {
      AdminAllDTO dto = adminProdMapper.prodAllList(prod_num);
      List<String> imgList = new ArrayList<>();
      List<String> genderList = new ArrayList<String>();
      HttpSession session = req.getSession();
      upPath = session.getServletContext().getRealPath("images");
      for (int i = 0; i < gender.length; i++) {
         genderList.add(gender[i]);
      }
      if (dto == null) {
         dto = adminProdMapper.delList(prod_num);
      }
      imgList.add(dto.getProd_img1());
      System.out.println("dto이미지" + dto.getProd_img1());
      if (dto.getProd_img2() != null) {
         imgList.add(dto.getProd_img2());
      }
      if (dto.getProd_img3() != null) {
         imgList.add(dto.getProd_img3());
      }
      if (dto.getProd_img4() != null) {
         imgList.add(dto.getProd_img4());
      }
      if (dto.getProd_img5() != null) {
         imgList.add(dto.getProd_img5());
      }
      List<String> brandList = adminProdMapper.brandList();
      req.setAttribute("brandList2", brandList);
      List<String> brand_kr_list = adminProdMapper.brand_kr_list();
      req.setAttribute("brand_kr_list", brand_kr_list);
      req.setAttribute("upPath", upPath);
      req.setAttribute("cate_kr_brand", dto.getCate_kr_brand());
      req.setAttribute("cate_brand", dto.getCate_brand());
      req.setAttribute("dto", dto);
      req.setAttribute("imgList", imgList);
      req.setAttribute("genderList", genderList);
      return "/admin/product/prodEditForm";
   }

   @RequestMapping(value = "/prodEdit.admin", method = RequestMethod.POST)
   public String admin_edit_ok(@ModelAttribute AdminProdDTO dto, HttpServletRequest req,
         @ModelAttribute ProdImgDTO imgDTO,@RequestParam(required = false) int originPrice) {
      MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
      HttpSession session = req.getSession();
      upPath = session.getServletContext().getRealPath("images");
      Iterator<String> it = mr.getFileNames();
      System.out.println(imgDTO.getProd_img1());
      dto.setProd_kr_subject(dto.getCate_kr_brand() + " " + dto.getProd_kr_name() + " " + dto.getProd_kr_color());
      dto.setProd_subject(dto.getCate_brand() + " " + dto.getProd_name() + " " + dto.getProd_color());
      while (it.hasNext()) {
         String fileName = it.next();
         MultipartFile mf = mr.getFile(fileName);
         String realName = mf.getOriginalFilename();
         System.out.println("파일 이미지 :" + realName);
         File file = new File(upPath, fileName);
         if (mf.getSize() != 0) {
            if (!file.exists()) {
               file.mkdirs();
            }
            try {
               mf.transferTo(new File(upPath, realName));
            } catch (IllegalStateException | IOException e) {
               e.printStackTrace();
            }
         }
         if (realName == null || realName.equals("")) {
            break;
         }
         if (imgDTO.getProd_img1() == null || imgDTO.getProd_img1().equals("")) {
            imgDTO.setProd_img1(realName);
         } else if (imgDTO.getProd_img2() == null || imgDTO.getProd_img2().equals("")) {
            imgDTO.setProd_img2(realName);
         } else if (imgDTO.getProd_img3() == null || imgDTO.getProd_img3().equals("")) {
            imgDTO.setProd_img3(realName);
         } else if (imgDTO.getProd_img4() == null || imgDTO.getProd_img4().equals("")) {
            imgDTO.setProd_img4(realName);
         } else if (imgDTO.getProd_img5() == null || imgDTO.getProd_img5().equals("")) {
            imgDTO.setProd_img5(realName);
         }
      }
      if (imgDTO.getProd_img1() == null || imgDTO.getProd_img1().equals("")) {
         if (imgDTO.getProd_img2() != null) {
            imgDTO.setProd_img1(imgDTO.getProd_img2());
            imgDTO.setProd_img2("");
         }
         if (imgDTO.getProd_img3() != null) {
            imgDTO.setProd_img1(imgDTO.getProd_img3());
            imgDTO.setProd_img3("");
         }
         if (imgDTO.getProd_img4() != null) {
            imgDTO.setProd_img1(imgDTO.getProd_img4());
            imgDTO.setProd_img4("");
         }
         if (imgDTO.getProd_img5() != null) {
            imgDTO.setProd_img1(imgDTO.getProd_img5());
            imgDTO.setProd_img5("");
         }
      }
      if (imgDTO.getProd_img2() == null || imgDTO.getProd_img2().equals("")) {
         imgDTO.setProd_img2("");
      }
      if (imgDTO.getProd_img3() == null || imgDTO.getProd_img3().equals("")) {
         imgDTO.setProd_img3("");
      }
      if (imgDTO.getProd_img4() == null || imgDTO.getProd_img4().equals("")) {
         imgDTO.setProd_img4("");
      }
      if (imgDTO.getProd_img5() == null || imgDTO.getProd_img5().equals("")) {
         imgDTO.setProd_img5("");
      }
      int res = adminProdMapper.prodImgEdit(imgDTO);
      req.setAttribute("url", "prodList.admin");
      if (res == 0) {
         req.setAttribute("msg", "이미지수정 실패");
      } else {
         req.setAttribute("msg", "이미지 수정 성공");
      }
      int prod_res = adminProdMapper.prodEdit(dto);
      List<Integer> prodNumList = adminProdMapper.prodNumList(dto);
      System.out.println("바꾸는가격:"+dto.getProd_price()+",기존가격:"+originPrice);
      Map<String,String> map = new HashMap<>();
      map.put("info", "");
      if((dto.getProd_price()-originPrice) != 0){
         for(int i :prodNumList) {
            List<Integer> cartUserNumList = userAlarmMapper.getCartUserNumList(i);
            for(int user_num:cartUserNumList) {
               map.put("alarm_kind_num", String.valueOf(i));
               map.put("getUser_num",String.valueOf(user_num));
               map.put("alarm_kind","cart_price");
               int cartCount = userAlarmMapper.getCartCount(map);
               if(cartCount ==0) {
                  // sendUser_num 에 기존가격을 담고 , followCheck 에 변경가격 최신화
                  map.put("sendUser_num",String.valueOf(originPrice));
                  map.put("followCheck",String.valueOf(dto.getProd_price()));
                  //기존 담아준 cartAlarm에 set 해준다
                  userAlarmMapper.insertAlarm(map);
               }
               if(cartCount > 0) {
                  userAlarmMapper.setCartAlarm(map);
               }
            }
         }
      }
      
      if (prod_res == 0) {
         req.setAttribute("msg", "상품 수정 실패");
      } else {
         req.setAttribute("msg", "상품 수정 성공 ! 목록으로 이동합니다.");
      }

      return "/message";
   }

   // 관리자 상품 입력 결과
   @RequestMapping(value = "/prodInput.admin", method = RequestMethod.POST)
   public String admin_prodInputOk(@ModelAttribute AdminProdDTO dto, HttpServletRequest req) {
      MultipartHttpServletRequest mr = (MultipartHttpServletRequest) req;
      HttpSession session = req.getSession();
      upPath = session.getServletContext().getRealPath("images");
      Iterator<String> it = mr.getFileNames();
      List<String> fileList = new ArrayList<>();
      dto.setProd_kr_subject(dto.getCate_kr_brand() + " " + dto.getProd_kr_name() + " " + dto.getProd_kr_color());
      dto.setProd_subject(dto.getCate_brand() + " " + dto.getProd_name() + " " + dto.getProd_color());
      int subject = adminProdMapper.prodSubjectCount(dto);
      if (subject > 0) {
         req.setAttribute("msg", "중복되는 상품명이 존재합니다.");
         req.setAttribute("url", "prodInput.admin");
         return "/message";
      }
      ProdImgDTO imgDTO = new ProdImgDTO();
      while (it.hasNext()) {
         String fileName = it.next();
         MultipartFile mf = mr.getFile(fileName);
         String realName = mf.getOriginalFilename();
         File file = new File(upPath, fileName);
         if (mf.getSize() != 0) {
            if (!file.exists()) {
               file.mkdirs();
            }
            try {
               mf.transferTo(new File(upPath, realName));
            } catch (IllegalStateException | IOException e) {
               e.printStackTrace();
            }
         }
         if (realName == null || realName.equals("")) {
            break;
         }
         fileList.add(realName);
         if (imgDTO.getProd_img1() == null || imgDTO.getProd_img1().equals("")) {
            imgDTO.setProd_img1(realName);
         } else if (imgDTO.getProd_img2() == null || imgDTO.getProd_img2().equals("")) {
            imgDTO.setProd_img2(realName);
         } else if (imgDTO.getProd_img3() == null || imgDTO.getProd_img3().equals("")) {
            imgDTO.setProd_img3(realName);
         } else if (imgDTO.getProd_img4() == null || imgDTO.getProd_img4().equals("")) {
            imgDTO.setProd_img4(realName);
         } else if (imgDTO.getProd_img5() == null || imgDTO.getProd_img5().equals("")) {
            imgDTO.setProd_img5(realName);
         }
      }
      // 기본상품 등록
      int base_res = adminProdMapper.prodBaseInput(dto);
      if (base_res == 0) {
         req.setAttribute("msg", "기본상품 등록중 오류발생");
         req.setAttribute("url", "prodInput.admin");
      }
      // 그룹번호 빼오기
      int prod_group = adminProdMapper.getProdGroup(dto.getProd_kr_subject());
      if (prod_group == 0) {
         req.setAttribute("msg", "번호색인 오류발생");
         req.setAttribute("url", "prodInput.admin");
         return "/message";
      }

      // 상품 이미지 등록
      imgDTO.setProd_num(prod_group);
      if (imgDTO.getProd_img2() == null || imgDTO.getProd_img2().equals("")) {
         imgDTO.setProd_img2("");
      }
      if (imgDTO.getProd_img3() == null || imgDTO.getProd_img3().equals("")) {
         imgDTO.setProd_img3("");
      }
      if (imgDTO.getProd_img4() == null || imgDTO.getProd_img4().equals("")) {
         imgDTO.setProd_img4("");
      }
      if (imgDTO.getProd_img5() == null || imgDTO.getProd_img5().equals("")) {
         imgDTO.setProd_img5("");
      }
      int img_res = adminProdMapper.prodImgInput(imgDTO);
      if (img_res == 0) {
         req.setAttribute("msg", "이미지 등록중 오류발생");
         req.setAttribute("url", "prodInput.admin");
      }
      // 사이즈상품 등록
      int size_res = 0;

      // 의류 상품 사이즈 자동 등록
      if (dto.getCate_kr_type().equals("상의") || dto.getCate_kr_type().equals("하의")
            || dto.getCate_kr_type().equals("아우터")) {
         dto.setProd_group(prod_group);
         for (int i = 0; i < cloth_size.length; i++) {
            dto.setProd_size(cloth_size[i]);
            size_res = adminProdMapper.prodInput(dto);
            if (size_res == 0) {
               req.setAttribute("msg", "사이즈 등록중 오류발생");
               req.setAttribute("url", "prodInput.admin");
               return "/message";
            }
         }
      }
      // 신발 상품 사이즈 자동등록
      else if (dto.getCate_kr_type().equals("신발")) {
         dto.setProd_group(prod_group);
         for (int i = 0; i < shoe_size.length; i++) {
            dto.setProd_size(shoe_size[i]);
            size_res = adminProdMapper.prodInput(dto);
            if (size_res == 0) {
               req.setAttribute("msg", "사이즈등록중 오류발생");
               req.setAttribute("url", "prodInput.admin");
               return "message";
            }
         }
      }
      // 잡화 상품 사이즈 자동등록
      else {
         dto.setProd_size("ONESIZE");
         dto.setProd_group(prod_group);
         size_res = adminProdMapper.prodInput(dto);
         if (size_res == 0) {
            req.setAttribute("msg", "사이즈 등록중 오류발생");
            req.setAttribute("url", "prodInput.admin");
         }
      }
      req.setAttribute("msg", "상품 등록 성공 ! 목록페이지로 이동합니다.");
      req.setAttribute("url", "prodList.admin");
      return "/message";
   }

   // 관리자 카테고리 입력 폼
   @RequestMapping(value = "/prodCateInput.admin", method = RequestMethod.GET)
   public String admin_prodCateInput() {
      return "/admin/product/prodCateForm";
   }

   // 관리자 카테고리 입력 결과
   @RequestMapping(value = "/prodCateInput.admin", method = RequestMethod.POST)
   public String admin_prodCateInputOk(@ModelAttribute ProdCateDTO dto, HttpServletRequest req) {
      int cateResult = adminProdMapper.cateCheck(dto);
      int cateKrResult = adminProdMapper.cateKrCheck(dto);
      if (cateResult > 0 || cateKrResult > 0) {
         req.setAttribute("msg", "중복되는 카테고리가 존재합니다.");
         req.setAttribute("url", "prodCateInput.admin");
         return "/message";
      }
      int res = adminProdMapper.prodCateInput(dto);
      if (res > 0) {
         req.setAttribute("msg", "카테고리 등록성공");
         req.setAttribute("url", "prodCateList.admin");
      } else {
         req.setAttribute("msg", "카테고리 등록 오류발생");
         req.setAttribute("url", "prodCateInput.admin");
      }
      return "/message";
   }

   // 관리자 추천상품 등록 AJAX요청
   @PostMapping("/pickCate.admin")
   @ResponseBody
   public List<PickCateListDTO> responsePickCate(@RequestParam(value = "str", required = false) String str,
         @RequestParam(value = "cate_code", required = false) String cate_code,
         @RequestParam(value = "result", required = false) String result,
         @RequestParam(value = "val", required = false) String val) {
      List<PickCateListDTO> list = new ArrayList<>();
      Map<String, String> map = new HashMap<>();
      System.out.println("result = " + result);
      System.out.println("str = " + str);
      System.out.println("val = " + val);
      if (str.equals("tab_name")) {
         map.put("result", result);
         map.put("value1", str);
         map.put("value2", val);
         list = adminProdMapper.selectPickList(map);
      } else if (str.equals("pick_name")) {
         map.put("result", result);
         map.put("value1", str);
         map.put("value2", val);
         list = adminProdMapper.selectPickList(map);
      } else if (str.equals("pick_kr_name")) {
         map.put("result", result);
         map.put("value1", cate_code);
         map.put("value2", val);
         list = adminProdMapper.selectLastPick(map);
         System.out.println(list.get(0).getCate_num());
      }
      return list;
   }

   // 관리자 상품 등록 AJAX 요청
   @PostMapping("/cate.admin")
   @ResponseBody
   public List<ProdCateDTO> responseCate(@RequestParam(value = "str", required = false) String str,
         @RequestParam(value = "cate_code", required = false) String cate_code,
         @RequestParam(value = "cate_kr_brand", required = false) String cate_kr_brand) {
      System.out.println(str);
      System.out.println(cate_code);
      String cate = null;
      Map<String, String> map = new HashMap<>();
      List<ProdCateDTO> cateList = new ArrayList<>();
      if (str.equals("cate_kr_brand")) {
         System.out.println("들어옴");
         cate = adminProdMapper.cate_brand(cate_code);
         map.put("subVal", cate);
         map.put("value", "cate_kr_brand");
         map.put("value3", "cate_kr_type");
         map.put("value2", "cate_brand");
         map.put("brand", "cate_brand");
         map.put("result", cate_code);
         cateList = adminProdMapper.cateTypeList(map);
         return cateList;
      } else if (str.equals("cate_kr_type")) {
         System.out.println("타입 들어옴 :" + cate_code);
         System.out.println("브랜드한글:" + cate_kr_brand);
         map.put("value", "cate_kr_type");
         map.put("value2", "cate_type");
         map.put("value3", "cate_kr_subType");
         map.put("subVal", cate_kr_brand);
         map.put("brand", "cate_kr_brand");
         map.put("result", cate_code);
         cateList = adminProdMapper.cateTypeList(map);
         System.out.println("신발:" + cateList.get(0).getCate_kr_subType());
         return cateList;
      } else if (str.equals("cate_kr_subType")) {
         System.out.println("서브타입 들어옴 :" + cate_code);
         map.put("value", "cate_kr_subType");
         map.put("result", cate_code);
         map.put("value3", "cate_kr_subType");
         map.put("value2", "cate_subType");
         map.put("subVal", cate_kr_brand);
         map.put("brand", "cate_kr_brand");
         cateList = adminProdMapper.cateTypeList(map);
         return cateList;
      }
      return null;
   }

   // 카테고리 리스트 페이지
   @RequestMapping("/prodCateList.admin")
   public String admin_prodCateList(HttpServletRequest req) {

      int pageSize = 10;
      String pageNum = req.getParameter("pageNum");
      if (pageNum == null) {
         pageNum = "1";
      }
      int currentPage = Integer.parseInt(pageNum);
      int startRow = (currentPage - 1) * pageSize + 1;
      int endRow = startRow + pageSize - 1;
      int count = adminProdMapper.getProdCateCount();
      if (endRow > count)
         endRow = count;
      List<ProdCateDTO> list = null;
      if (count > 0) {
         Map<String, String> map = new HashMap<>();
         map.put("start", String.valueOf(startRow));
         map.put("end", String.valueOf(endRow));
         list = adminProdMapper.prodCateList(map);
         int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
         int pageBlock = 3;
         int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
         int endPage = startPage + pageBlock - 1;
         if (endPage > pageCount)
            endPage = pageCount;
         req.setAttribute("startPage", startPage);
         req.setAttribute("endPage", endPage);
         req.setAttribute("pageBlock", pageBlock);
         req.setAttribute("pageCount", pageCount);
      }
      int rowNum = count - (currentPage - 1) * pageSize;
      req.setAttribute("rowNum", rowNum);
      req.setAttribute("count", count);
      req.setAttribute("prodCateList", list);
      return "admin/product/prodCateList";
   }

   // 카테고리 리스트 찾기 페이지
   @RequestMapping("/prodCateListFind.admin")
   public String admin_prodCateListFind(HttpServletRequest req,@RequestParam Map<String,String> map) {
      int pageSize = 10;
      String pageNum = req.getParameter("pageNum");
      if (pageNum == null) {
         pageNum = "1";
      }
      int currentPage = Integer.parseInt(pageNum);
      int startRow = (currentPage - 1) * pageSize + 1;
      int endRow = startRow + pageSize - 1;
      int count = adminProdMapper.getProdCateFindCount(map);
      if (endRow > count)
         endRow = count;
      List<ProdCateDTO> list = null;
      if (count > 0) {
         map.put("start", String.valueOf(startRow));
         map.put("end", String.valueOf(endRow));
         list = adminProdMapper.prodCateFindList(map);
         int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
         int pageBlock = 3;
         int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
         int endPage = startPage + pageBlock - 1;
         if (endPage > pageCount)
            endPage = pageCount;
         req.setAttribute("startPage", startPage);
         req.setAttribute("endPage", endPage);
         req.setAttribute("pageBlock", pageBlock);
         req.setAttribute("pageCount", pageCount);
      }
      int rowNum = count - (currentPage - 1) * pageSize;
      req.setAttribute("rowNum", rowNum);
      req.setAttribute("count", count);
      req.setAttribute("prodCateList", list);
      req.setAttribute("mode", "find");
      req.setAttribute("search", map.get("search"));
      req.setAttribute("searchString", map.get("searchString"));
      return "admin/product/prodCateList";
   }

   // 관리자 카테고리 삭제
   @RequestMapping("/prodCateDelete.admin")
   public String admin_prodCateDelete(int cate_num, HttpServletRequest req) {
      ProdCateDTO dto = adminProdMapper.getCate(cate_num);

      int cnt = adminProdMapper.prodCount(dto.getCate_brand());
      if (cnt == 0) {
         int res = adminProdMapper.prodCateDelete(cate_num);
         req.setAttribute("url", "prodCateList.admin");
         if (res > 0) {
            req.setAttribute("msg", "카테고리 삭제성공");
         } else {
            req.setAttribute("msg", "카테고리 삭제 오류발생");
         }
      } else {
         req.setAttribute("msg", "해당 브랜드가 존재하는 상품이 있습니다.");
         req.setAttribute("url", "prodCateList.admin");
      }
      return "/message";
   }

   @RequestMapping("/prodView.admin")
   public String admin_prodView(@RequestParam int prod_num, HttpServletRequest req) {
      AdminAllDTO dto = adminProdMapper.prodAllList(prod_num);
      HttpSession session = req.getSession();
      upPath = session.getServletContext().getRealPath("images");
      req.setAttribute("dto", dto);
      req.setAttribute("upPath", upPath);
      return "admin/product/prodView";
   }

   @RequestMapping("/prodImgAdd.admin")
   public String admin_imgAdd(HttpServletRequest req) {

      return "admin/product/prodForm";
   }

   @RequestMapping("/prodSearch.admin")
   public String admin_prodSearch(@RequestParam(required = false) Map<String, String> map, HttpServletRequest req) {
      if (map.get("mode").equals("N")) {
         List<AdminAllDTO> list1 = adminProdMapper.searchList(map.get("searchString"));
         List<AdminAllDTO> list = new ArrayList<>();
         HttpSession session = req.getSession();
         upPath = session.getServletContext().getRealPath("images");
         if (list1 != null) {
            int co = 0;
            for (int i = 0; i < list1.size(); i++) {
               ++co;
               AdminAllDTO dto = adminProdMapper.prodAllList(list1.get(i).getProd_num());
               list.add(dto);
               if (co == 9)
                  break;
            }
         }
         req.setAttribute("list", list);
         req.setAttribute("del", "N");
      }
      else if (map.get("mode").equals("Y")) {
         List<AdminAllDTO> list1 = adminProdMapper.searchDelList(map.get("searchString"));
         List<AdminAllDTO> list = new ArrayList<>();
         if (list1 != null) {
            int co = 0;
            for (int i = 0; i < list1.size(); i++) {
               ++co;
               AdminAllDTO dto = adminProdMapper.delList(list1.get(i).getProd_num());
               list.add(dto);
               if (co == 9)
                  break;
            }
         }
         req.setAttribute("list", list);
         req.setAttribute("del", "Y");
      }
      req.setAttribute("searchString", map.get("searchString"));
      List<ProdCateDTO> twoList = adminProdMapper.twoTypeAnother();
      List<String> brandList = adminProdMapper.brandList();
      List<String> cate_kr_type_list = adminProdMapper.cate_kr_typeList();
      List<ProdCateDTO> cateList = adminProdMapper.prodCateList();
      req.setAttribute("cate_kr_type_list", cate_kr_type_list);
      req.setAttribute("cateList", cateList);
      req.setAttribute("brandList", brandList);
      req.setAttribute("two", twoList);
      req.setAttribute("upPath", upPath);
      req.setAttribute("mode", map.get("mode"));
      return "admin/product/prodList";
   }

   @RequestMapping("/prodList.admin")
   public String admin_prodList(@RequestParam(required = false) Map<String, String> map, HttpServletRequest req) {
      if (map.get("del") == null)   map.put("del", "N");
      List<AdminAllDTO> list = new ArrayList<>();
      List<AdminAllDTO> getList = new ArrayList<>();
      HttpSession session = req.getSession();
      upPath = session.getServletContext().getRealPath("images");
      //있는상품
      if (map.get("del").equals("N")) {
         //상품 전체 목록일때
         if(map.get("type") == null) {
            System.out.println("type가 널");
            getList = adminProdMapper.delNProdList();
            if(getList != null) {
               int co = 0;
               for(AdminAllDTO dto : getList) {
                  if(co == 9) break;
                  list.add(dto);
                  co++;
               }
            }
         }
         //카테고리에서 브랜드,카테대분류,카테소분류 눌렸을때
         else {
            System.out.println("type가 낫널");
            getList = adminProdMapper.delNModeProdList(map);
            if(getList != null) {
               int co = 0;
               for(AdminAllDTO dto : getList) {
                  if(co == 9) break;
                  list.add(dto);
                  co++;
               }
            }
            req.setAttribute("type", map.get("type"));      //브랜드,카테대분류/카테소분류 이름
            req.setAttribute("subType", map.get("subType"));//type에 해당하는 값
         }
         req.setAttribute("del", "N");
      }
      //삭제상품
      else {
         //상품 전체 목록일때
         if(map.get("type") == null) {
            System.out.println("삭제에서 type가 널");
            getList = adminProdMapper.delYProdList();
            if(getList != null) {
               int co = 0;
               for(AdminAllDTO dto : getList) {
                  if(co == 9) break;
                  list.add(dto);
                  co++;
               }
            }
         }
         //카테고리에서 브랜드,카테대분류,카테소분류 눌렸을때
         else {
            System.out.println("삭제에서 type가 낫널");
            getList = adminProdMapper.delYModeProdList(map);
            if(getList != null) {
               int co = 0;
               for(AdminAllDTO dto : getList) {
                  if(co == 9) break;
                  list.add(dto);
                  co++;
               }
            }
            req.setAttribute("type", map.get("type"));      //브랜드,카테대분류/카테소분류 이름
            req.setAttribute("subType", map.get("subType"));//type에 해당하는 값
         }
         req.setAttribute("del", "Y");
      }
      if(getList != null) req.setAttribute("listSize", getList.size());
      else req.setAttribute("listSize", 0);
      req.setAttribute("list", list);
      
      List<ProdCateDTO> twoList = adminProdMapper.twoTypeAnother();
      List<String> brandList = adminProdMapper.brandList();
      List<String> cate_kr_type_list = adminProdMapper.cate_kr_typeList();
      List<ProdCateDTO> cateList = adminProdMapper.prodCateList();
      req.setAttribute("cate_kr_type_list", cate_kr_type_list);
      req.setAttribute("cateList", cateList);
      req.setAttribute("brandList", brandList);
      req.setAttribute("two", twoList);
      req.setAttribute("upPath", upPath);
      return "admin/product/prodList";
   }

   @RequestMapping("/prodRegist.admin")
   public String prod_regist(int prod_num, HttpServletRequest req) {
      AdminAllDTO pdto = adminProdMapper.delList(prod_num);
      ProdCateDTO dto = new ProdCateDTO();
      dto.setCate_brand(pdto.getCate_brand());
      dto.setCate_kr_brand(pdto.getCate_kr_brand());
      dto.setCate_type(pdto.getCate_type());
      dto.setCate_kr_type(pdto.getCate_kr_type());
      dto.setCate_subType(pdto.getCate_subType());
      dto.setCate_kr_subType(pdto.getCate_kr_subType());
      int cateResult = adminProdMapper.cateCheck(dto);
      int cateKrResult = adminProdMapper.cateKrCheck(dto);
      if (cateResult > 0 || cateKrResult > 0) {
         req.setAttribute("msg", "제품재등록 성공");
         req.setAttribute("url", "prodList.admin");
         int res = adminProdMapper.prodRegist(prod_num);
      } else {
         int res = adminProdMapper.prodRegist(prod_num);
         int cate_input = adminProdMapper.prodCateInput(dto);
         req.setAttribute("msg", "카테고리 및 제품 재등록성공");
      }
      req.setAttribute("url", "prodList.admin");
      return "/message";
   }

   // 상품삭제
   @RequestMapping("/prodDelete.admin")
   public String prod_delete(int prod_num, HttpServletRequest req) {
      int res = adminProdMapper.prodDelete(prod_num);
      if (res == 0) {
         req.setAttribute("msg", "삭제중 에러발생, 관리자에게 문의하세요 ");
         req.setAttribute("url", "prodEdit.admin?prod_num=" + prod_num);
      } else {
         req.setAttribute("msg", "삭제 성공 ! 목록으로 이동합니다.");
         req.setAttribute("url", "prodList.admin");
      }
      return "/message";
   }

   // 추천상품 카테고리 리스트
   @RequestMapping("/pickCateList.admin")
   public String pickCateList(HttpServletRequest req) {
      int pageSize = 5;
      String pageNum = req.getParameter("pageNum");
      if (pageNum == null){
         pageNum = "1";
      }
      int currentPage = Integer.parseInt(pageNum);
      int startRow = (currentPage - 1) * pageSize + 1;
      int endRow = startRow + pageSize - 1;
      int count = adminProdMapper.pickCateCount();
      if (endRow>count) endRow = count;
      List<PickCateListDTO> pickCateList = null;
      if (count>0){
         Map<String,String> map = new HashMap<>();
         map.put("start", String.valueOf(startRow));
         map.put("end", String.valueOf(endRow));
         pickCateList = adminProdMapper.pickCateList(map);
         int pageCount = count/pageSize + (count%pageSize==0 ? 0 : 1);
         int pageBlock = 3;
         int startPage = (currentPage-1)/pageBlock * pageBlock + 1;
         int endPage = startPage + pageBlock - 1;
         if (endPage > pageCount) endPage = pageCount;
         req.setAttribute("startPage", startPage);
         req.setAttribute("endPage", endPage);
         req.setAttribute("pageBlock", pageBlock);
         req.setAttribute("pageCount", pageCount);
      }
      int rowNum = count - (currentPage - 1) * pageSize;
      req.setAttribute("rowNum",rowNum);
      req.setAttribute("count", count);
      req.setAttribute("pickCateList", pickCateList);
      return "admin/product/prodPickCateList";
   }

   // 추천상품 카테고리 추가
   @RequestMapping("/pickCateInput.admin")
   public String prod_pickCateInput(PickCateListDTO dto, HttpServletRequest req) {
      // 추천상품 카테고리 검사
      int checkCate = adminProdMapper.pickCateCheck(dto);
      if (checkCate <= 0) {
         int input = adminProdMapper.pickCateInput(dto);
         if (input > 0) {
            req.setAttribute("msg", "카테고리 등록 성공! 목록으로 이동합니다.");
         } else {
            req.setAttribute("msg", "카테고리등록중 오류발생");
         }
      } else {
         req.setAttribute("msg", "중복되는 카테고리가 존재합니다.");
      }
      req.setAttribute("url", "pickCateList.admin");
      return "/message";
   }

   // 추천상품 카테고리 삭제
   @RequestMapping("/pickCateDelete.admin")
   public String pickCateDelete(int cate_num, HttpServletRequest req) {
      int res = adminProdMapper.pickCateDelete(cate_num);
      if (res > 0) {
         req.setAttribute("msg", "카테고리 삭제 성공 !");
      } else {
         req.setAttribute("msg", "카테고리 삭제중 오류발생");
      }
      req.setAttribute("url", "pickCateList.admin");
      return "/message";
   }

   // 추천상품 등록 탭
   @RequestMapping(value = "/pickProdInput.admin", method = RequestMethod.GET)
   public String prod_pickProdInput(HttpServletRequest req) {
      List<String> list = adminProdMapper.pickCateTab();
      HttpSession session = req.getSession();
      upPath = session.getServletContext().getRealPath("images");
      req.setAttribute("pickCateList", list);
      req.setAttribute("upPath", upPath);
      return "admin/product/pickProdInput";
   }

   // 추천상품 등록 완료
   @RequestMapping(value = "/pickProdInput.admin", method = RequestMethod.POST)
   public String prod_pickProdInputOk(HttpServletRequest req, PickProdListDTO dto) {
      int prodPickCheck = adminProdMapper.pickProdCheck(dto);
      System.out.println("체크 :" + prodPickCheck);
      if (prodPickCheck <= 0) {
         int res = adminProdMapper.pickProdInput(dto);
         if (res > 0) {
            req.setAttribute("msg", "추천상품 등록 성공");
            req.setAttribute("url", "pickProdList.admin");
         } else {
            req.setAttribute("msg", "추천상품등록중 오류발생");
            req.setAttribute("url", "pickProdInput.admin");
         }
      } else {
         req.setAttribute("msg", "중복되는 상품이 존재합니다.");
         req.setAttribute("url", "pickProdInput.admin");
      }
      return "/message";
   }

   @RequestMapping("/pickProdList.admin")
   public String prod_pickProdList(HttpServletRequest req) {
      
      int pageSize = 5;
      String pageNum = req.getParameter("pageNum");
      if (pageNum == null){
         pageNum = "1";
      }
      int currentPage = Integer.parseInt(pageNum);
      int startRow = (currentPage - 1) * pageSize + 1;
      int endRow = startRow + pageSize - 1;
      int count = adminProdMapper.pickProdCount();
      if (endRow>count) endRow = count;
      List<AdminAllDTO> list = null;
      if (count>0){
         Map<String,String> map = new HashMap<>();
         map.put("start", String.valueOf(startRow));
         map.put("end", String.valueOf(endRow));
         list = adminProdMapper.pickProd(map);
         int pageCount = count/pageSize + (count%pageSize==0 ? 0 : 1);
         int pageBlock = 3;
         int startPage = (currentPage-1)/pageBlock * pageBlock + 1;
         int endPage = startPage + pageBlock - 1;
         if (endPage > pageCount) endPage = pageCount;
         req.setAttribute("startPage", startPage);
         req.setAttribute("endPage", endPage);
         req.setAttribute("pageBlock", pageBlock);
         req.setAttribute("pageCount", pageCount);
      }
      int rowNum = count - (currentPage - 1) * pageSize;
      req.setAttribute("rowNum",rowNum);
      req.setAttribute("count", count);
      req.setAttribute("list", list);
      return "admin/product/pickProdList";
   }
   
   @RequestMapping("/pickProdFind.admin")
   public String prod_pickProdFind(HttpServletRequest req,@RequestParam Map<String,String> map) {
      int pageSize = 5;
      String pageNum = req.getParameter("pageNum");
      if (pageNum == null){
         pageNum = "1";
      }
      int currentPage = Integer.parseInt(pageNum);
      int startRow = (currentPage - 1) * pageSize + 1;
      int endRow = startRow + pageSize - 1;
      int count = adminProdMapper.pickProdFindCount(map);
      System.out.println("갯수:"+count);
      if (endRow>count) endRow = count;
      List<AdminAllDTO> list = null;
      if (count>0){
         map.put("start", String.valueOf(startRow));
         map.put("end", String.valueOf(endRow));
         list = adminProdMapper.pickProdFind(map);
         int pageCount = count/pageSize + (count%pageSize==0 ? 0 : 1);
         int pageBlock = 3;
         int startPage = (currentPage-1)/pageBlock * pageBlock + 1;
         int endPage = startPage + pageBlock - 1;
         if (endPage > pageCount) endPage = pageCount;
         req.setAttribute("startPage", startPage);
         req.setAttribute("endPage", endPage);
         req.setAttribute("pageBlock", pageBlock);
         req.setAttribute("pageCount", pageCount);
      }
      int rowNum = count - (currentPage - 1) * pageSize;
      req.setAttribute("rowNum",rowNum);
      req.setAttribute("count", count);
      req.setAttribute("list", list);
      req.setAttribute("search", map.get("search"));
      req.setAttribute("searchString", map.get("searchString"));
      req.setAttribute("mode", "find");
      return "admin/product/pickProdList";
   }
   @RequestMapping("/pickProdDel.admin")
   public String prod_pickDelete(HttpServletRequest req, PickProdListDTO dto) {
      int res = adminProdMapper.pickProdDelete(dto);
      if (res > 0) {
         req.setAttribute("msg", "추천상품 삭제 성공");
      } else {
         req.setAttribute("msg", "추천상품 삭제중 오류 발생");
      }
      req.setAttribute("url", "pickProdList.admin");
      return "/message";

   }

   @RequestMapping(value = "/size_qty_edit.admin", method = RequestMethod.GET)
   public String size_qtyForm(HttpServletRequest req, int prod_num) {
      List<AdminAllDTO> list = userShopMapper.getSizeList(prod_num);
      AdminAllDTO dto = adminProdMapper.prodAllList(prod_num);
      HttpSession session = req.getSession();
      upPath = session.getServletContext().getRealPath("images");
      req.setAttribute("dto", dto);
      req.setAttribute("list", list);
      req.setAttribute("upPath", upPath);
      return "admin/product/prodSize";
   }

   @RequestMapping(value = "/size_qty_edit.admin", method = RequestMethod.POST)
   public String size_qty_edit(@RequestParam(required = false) Map<String, String> map, HttpServletRequest req) {
      AdminProdDTO dto = new AdminProdDTO();
      dto.setProd_num(Integer.parseInt(map.get("prod_num")));
      Map<String,String> hMap = new HashMap<>();
      hMap.put("alarm_kind", "cart_qty");
      AdminAllDTO adto = adminProdMapper.prodAllList(dto.getProd_num());
      if (adto.getCate_kr_type().equals("신발")) {
         for (int i = 0; i < shoe_size.length; i++) {
            System.out.println(i + " 사이즈 :" + map.get("edit" + shoe_size[i]));
            if (map.get("edit" + shoe_size[i]) != null) {
               dto.setProd_qty(Integer.parseInt(map.get("edit" + shoe_size[i])));
               dto.setProd_size(shoe_size[i]);
               //기존 DTO 꺼내오기
               
               // 매입
               SalesAllDTO salesDTO = adminProdMapper.getSalesInfo(dto);
               salesDTO.setReg_date(adminProdMapper.getSysDate());
               System.out.println("수량1:" + salesDTO.getProd_qty());
               salesDTO.setProd_qty(dto.getProd_qty() - salesDTO.getProd_qty());
               System.out.println("수량2:" + salesDTO.getProd_qty());
               salesDTO.setMoney((int) (salesDTO.getProd_price() * 0.7 * salesDTO.getProd_qty()));
               System.out.println("총 수출:" + salesDTO.getMoney());
               adminProdMapper.directExport(salesDTO);
               AdminProdDTO bdto = adminProdMapper.getProd_before(dto);
               List<Integer> user_numList = userAlarmMapper.getCartUserNumList(bdto.getProd_num());
               int res = adminProdMapper.edit_prod_qty(dto);
               hMap.put("alarm_kind_num",String.valueOf(bdto.getProd_num()));
               hMap.put("info", "");
               System.out.println("갯수는:"+dto.getProd_qty());
               if((dto.getProd_qty()-bdto.getProd_qty()) > 0 ){
                  for(int num : user_numList) {
                     hMap.put("getUser_num", String.valueOf(num));
                     int cartCount = userAlarmMapper.getCartCount(hMap);
                     if(cartCount == 0) {
                        //sendUser_num 에 변경된 수량을 담아주고  followCheck 에 이전수량을 담아준다.
                        hMap.put("sendUser_num",String.valueOf(dto.getProd_qty()));
                        hMap.put("followCheck", String.valueOf(bdto.getProd_qty()));
                        userAlarmMapper.insertAlarm(hMap);
                     }
                     if(cartCount > 0) {
                        userAlarmMapper.setCartAlarm(hMap);
                     }
                  }
                  
               }
               if (res == 0) {
                  req.setAttribute("msg", "수량수정중 실패");
                  req.setAttribute("url", "prodEdit.admin?prod_num=" + map.get("prod_num"));
                  return "/message";
               }
               }
         }
      }
      if (adto.getCate_kr_type().equals("상의") || adto.getCate_kr_type().equals("아우터")
            || adto.getCate_kr_type().equals("하의")) {
         for (int i = 0; i < cloth_size.length; i++) {
            if (map.get("edit" + cloth_size[i]) != null) {
               dto.setProd_qty(Integer.parseInt(map.get("edit" + cloth_size[i])));
               dto.setProd_size(cloth_size[i]);
               // 매입
               SalesAllDTO salesDTO = adminProdMapper.getSalesInfo(dto);
               salesDTO.setReg_date(adminProdMapper.getSysDate());
               System.out.println("수량1:" + salesDTO.getProd_qty());
               salesDTO.setProd_qty(dto.getProd_qty() - salesDTO.getProd_qty());
               System.out.println("수량2:" + salesDTO.getProd_qty());
               salesDTO.setMoney((int) (salesDTO.getProd_price() * 0.7 * salesDTO.getProd_qty()));
               System.out.println("총 수출:" + salesDTO.getMoney());
               adminProdMapper.directExport(salesDTO);
               AdminProdDTO bdto = adminProdMapper.getProd_before(dto);
               List<Integer> user_numList = userAlarmMapper.getCartUserNumList(bdto.getProd_num());
               int res = adminProdMapper.edit_prod_qty(dto);
               hMap.put("alarm_kind_num",String.valueOf(bdto.getProd_num()));
               hMap.put("info", "");
               System.out.println("갯수는:"+dto.getProd_qty());
               if((dto.getProd_qty()-bdto.getProd_qty()) > 0 ){
                  for(int num : user_numList) {
                     hMap.put("getUser_num", String.valueOf(num));
                     int cartCount = userAlarmMapper.getCartCount(hMap);
                     if(cartCount == 0) {
                        //sendUser_num 에 변경된 가격을 담아주고  followCheck 에 이전가격을 담아준다.
                        hMap.put("sendUser_num",String.valueOf(dto.getProd_qty()));
                        hMap.put("followCheck", String.valueOf(bdto.getProd_qty()));
                        userAlarmMapper.insertAlarm(hMap);
                        System.out.println("수량 인서트 됨");
                     }
                     if(cartCount > 0) {
                        userAlarmMapper.setCartAlarm(hMap);
                     }
                  }
               }
               if (res == 0) {
                  req.setAttribute("msg", "수량수정중 실패");
                  req.setAttribute("url", "prodEdit.admin?prod_num=" + map.get("prod_num"));
                  return "/message";
               }
            }
         }
      } else {
         if (map.get("editONESIZE") != null) {
            dto.setProd_qty(Integer.parseInt(map.get("editONESIZE")));
            dto.setProd_size("ONESIZE");
            // 매입
            SalesAllDTO salesDTO = adminProdMapper.getSalesInfo(dto);
            salesDTO.setReg_date(adminProdMapper.getSysDate());
            System.out.println("수량1:" + salesDTO.getProd_qty());
            salesDTO.setProd_qty(dto.getProd_qty() - salesDTO.getProd_qty());
            System.out.println("수량2:" + salesDTO.getProd_qty());
            salesDTO.setMoney((int) (salesDTO.getProd_price() * 0.7 * salesDTO.getProd_qty()));
            System.out.println("총 수출:" + salesDTO.getMoney());
            adminProdMapper.directExport(salesDTO);
            List<Integer> user_numList = userAlarmMapper.getAlarmUserList(hMap);
            AdminProdDTO bdto = adminProdMapper.getProd_before(dto);
            int res = adminProdMapper.edit_prod_qty(dto);
            hMap.put("alarm_kind_num",String.valueOf(bdto.getProd_num()));
            hMap.put("info", "");
            if((dto.getProd_qty()-bdto.getProd_qty()) > 0 ){
               for(int num : user_numList) {
                  hMap.put("getUser_num", String.valueOf(num));
                  int cartCount = userAlarmMapper.getCartCount(hMap);
                  if(cartCount == 0) {
                     //sendUser_num 에 변경된 가격을 담아주고  followCheck 에 이전가격을 담아준다.
                     hMap.put("sendUser_num",String.valueOf(dto.getProd_qty()));
                     hMap.put("followCheck", String.valueOf(bdto.getProd_qty()));
                     userAlarmMapper.insertAlarm(hMap);
                  }
                  if(cartCount > 0) {
                     userAlarmMapper.setCartAlarm(hMap);
                  }
               }
            }
            if (res == 0) {
               req.setAttribute("msg", "수량수정중 실패");
               req.setAttribute("url", "prodEdit.admin?prod_num=" + map.get("prod_num"));
               return "/message";
            }
         }
      }
      req.setAttribute("msg", "수량 수정 성공!");
      req.setAttribute("prod_num", map.get("prod_num"));
      req.setAttribute("url", "prodEdit.admin?prod_num=" + map.get("prod_num"));
      return "/message";
   }

   @RequestMapping("/another_size_qty.admin")
   public String another_size_qty(@RequestParam String i, @RequestParam int qty, HttpServletRequest req) {
      req.setAttribute("i", i);
      req.setAttribute("qty", qty);
      return "admin/product/size_qty";
   }

   @RequestMapping("/size_qty.admin")
   public String size_qty(int i, int qty, HttpServletRequest req) {
      req.setAttribute("i", i);
      req.setAttribute("qty", qty);
      return "admin/product/size_qty";
   }

   @RequestMapping("/prod_qty_list.admin")
   public String prod_qty_list(HttpServletRequest req) {
      int pageSize = 5;
      HttpSession session = req.getSession();
      upPath = session.getServletContext().getRealPath("images");
      String pageNum = req.getParameter("pageNum");
      if (pageNum == null) {
         pageNum = "1";
      }
      System.out.println(pageNum);
      int currentPage = Integer.parseInt(pageNum);
      int count = adminProdMapper.getDeadCount();
      int startRow = (currentPage - 1) * pageSize + 1;
      int endRow = startRow + pageSize - 1;
      if (endRow > count)
         endRow = count;
      int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
      int pageBlock = 3;
      int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
      int endPage = startPage + pageBlock - 1;
      if (endPage > pageCount)
         endPage = pageCount;
      Map<String, Integer> map = new HashMap<>();
      map.put("startRow", startRow);
      map.put("endRow", endRow);
      List<AdminAllDTO> list = adminProdMapper.deadList(map);
      req.setAttribute("list", list);
      req.setAttribute("pageNum", pageNum);
      req.setAttribute("startPage", startPage);
      req.setAttribute("endPage", endPage);
      req.setAttribute("pageBlock", pageBlock);
      req.setAttribute("pageCount", pageCount);
      req.setAttribute("upPath", upPath);
      return "admin/product/qty_list";
   }

   @RequestMapping("/qty_edit.admin")
   public String qty_edit(HttpServletRequest req, int prod_num) {
      AdminAllDTO dto = adminProdMapper.prod_qty_edit(prod_num);
      req.setAttribute("pageNum", req.getParameter("pageNum"));
      req.setAttribute("dto", dto);
      return "admin/product/edit_qty";
   }

   @RequestMapping("/qty_edit_ok.admin")
   public String qty_edit_ok(int prod_num, int prod_qty, HttpServletRequest req) {
      AdminAllDTO pdto = adminProdMapper.prod_qty_edit(prod_num);
      AdminProdDTO dto = new AdminProdDTO();
      String pageNum = req.getParameter("pageNum");
      System.out.println("pageNum = " + pageNum);
      dto.setProd_num(pdto.getProd_group());
      dto.setProd_qty(pdto.getProd_qty() + prod_qty);
      dto.setProd_size(pdto.getProd_size());
      // 매입
      SalesAllDTO salesDTO = adminProdMapper.getSalesInfo(dto);
      salesDTO.setReg_date(adminProdMapper.getSysDate());
      System.out.println("수량1:" + salesDTO.getProd_qty());
      salesDTO.setProd_qty(prod_qty);
      System.out.println("수량2:" + salesDTO.getProd_qty());
      salesDTO.setMoney((int) (salesDTO.getProd_price() * 0.7 * salesDTO.getProd_qty()));
      System.out.println("총 수출:" + salesDTO.getMoney());
      adminProdMapper.directExport(salesDTO);
      int res = adminProdMapper.edit_prod_qty(dto);
      if (res == 0) {
         req.setAttribute("msg", "등록중 오류발생");
      } else {
         req.setAttribute("msg", "수량수정성공");
      }
      req.setAttribute("url", "prod_qty_list.admin?pageNum=" + pageNum);
      return "/message";
   }

   @RequestMapping("/qty_list.admin")
   @ResponseBody
   public List<AdminAllDTO> qty_listSearch(@RequestParam(required = false) Map<String, String> map) {
      System.out.println("searchString = " + map.get("searchString"));
      List<AdminAllDTO> list = adminProdMapper.searchList(map.get("searchString"));
      return list;
   }

   @PostMapping("/prodListScroll.admin")
   public String admin_scrollProdList(@RequestParam Map<String,String> map,HttpServletRequest req) {
      List<AdminAllDTO> getList = new ArrayList<>();
      //삭제 상품 아닐때
      if (map.get("del").equals("N")) {
         //검색 아닐때
         if(map.get("searchString").equals("")) {
            //상품 전체 목록일때
            if(map.get("type").equals("")) {
               System.out.println("mode가 널");
               getList = adminProdMapper.delNProdList();
            }
            //카테고리에서 브랜드,카테대분류,카테소분류 눌렸을때
            else {
               getList = adminProdMapper.delNModeProdList(map);
            }
         }
         //검색일때
         else {
            getList = adminProdMapper.searchList(map.get("searchString"));
         }
      }
      //삭제상품
      else {
         if(map.get("searchString").equals("")) {
            //상품 전체 목록일때
            if(map.get("type").equals("")) {
               System.out.println("mode가 널");
               getList = adminProdMapper.delYProdList();
            }
            //카테고리에서 브랜드,카테대분류,카테소분류 눌렸을때
            else {
               getList = adminProdMapper.delYModeProdList(map);
            }
         }else {
            getList = adminProdMapper.searchDelList(map.get("searchString"));
         }
         
      }
      req.setAttribute("list", getList);
      req.setAttribute("count", map.get("count"));
      System.out.println("스크롤 리스트 사이즈 :"+getList.size());
      System.out.println("카운트 :"+map.get("count"));
      return "admin/product/prodListScroll";
   }

}