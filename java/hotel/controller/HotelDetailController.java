package hotel.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import hotel.model.Hotel;
import hotel.model.HotelDao;
import hotel.model.Room;
import hotel.model.RoomDao;
import hotel.model.Search;
import member.model.ReviewComposite;
import member.model.ReviewCompositeDao;

@Controller
public class HotelDetailController {

	private final String command="hotelDetail.ho";
	private final String getPage="hotelDetail";
	
	@Autowired
	private HotelDao hotelDao;
	
	@Autowired
	private RoomDao roomDao;
	
	@Autowired
	private ReviewCompositeDao rvcDao;
	
	@RequestMapping(command)
	public String hotelDetail(@RequestParam("h_num") int h_num, Search search,
			Model model) {
		
		System.out.println("호텔넘버:" + h_num);
		System.out.println("area:"+search.getArea()+","+"checkin:"+search.getCheckin()+","+"checkout:"+search.getCheckout()+","+"adult:"+search.getAdult()+","
				+"child:"+search.getChild()+","+"room:"+search.getRoom()+","+
				"searchas:"+search.getSearchas()+","+"filterType:"+search.getFilterType() 
				);
		
		
		Hotel hotel=hotelDao.getHotelOne(h_num);
		
		List<ReviewComposite> review = rvcDao.getReviewList(h_num);
		
		List<Room> rooms=roomDao.getRoomList(hotel);
		hotel.setRooms(rooms);
		hotel.setImages(hotel.getH_image().split(";"));
		
		
		String address=hotel.getH_address1().substring(0,hotel.getH_address1().indexOf("(")-1);
		hotel.setH_address1(address);
		
		
		
		model.addAttribute("search",search);
		model.addAttribute("hotel",hotel);
		model.addAttribute("rooms",rooms);
		model.addAttribute("review", review);
		System.out.println("review : " + review);
		System.out.println(rooms);
		System.out.println("detail 지나감");
		return getPage;
	}

	private int parseInt(int h_num) {
		// TODO Auto-generated method stub
		return 0;
	}
}