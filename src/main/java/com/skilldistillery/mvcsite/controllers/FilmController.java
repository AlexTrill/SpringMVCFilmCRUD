package com.skilldistillery.mvcsite.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.skilldistillery.mvcsite.data.FilmDAO;
import com.skilldistillery.mvcsite.entities.Actor;
import com.skilldistillery.mvcsite.entities.Film;

@Controller
public class FilmController {

	@Autowired
	private FilmDAO filmDao;

	@RequestMapping(path = { "displayFilm.do" })
	public String displayFilm(Model model, String filmid) {

		int filmId;
		Film f = null;

		try {
			filmId = Integer.parseInt(filmid);
			f = filmDao.getFilmById(filmId);
		} catch (Exception e) {
		}
		
		model.addAttribute("film", f);
		return "WEB-INF/film.jsp";

	}
	
	@RequestMapping(path = "removeFilm.do")
	public String removeFilmById(Model model, String filmid) {

		int filmId;
		
		boolean isDeleted = false;
		
		try {
			filmId = Integer.parseInt(filmid);
			if (filmId >= 1000) {
				isDeleted = filmDao.deleteFilmById(filmId);
			}
		} catch (Exception e) {
			System.out.println("*** removeFilmById() Exception *** ");
			
			isDeleted = false;
		}
		
		return "redirect:/showFilm.do?filmid=-1" + "&removed=" + isDeleted;
	}
	
	@RequestMapping(path = "removeFilmFromTable.do")
	public String removeFilmbyId2(Model model, String filmid, String searchTerm) {
		
		int filmId;
		boolean filmDeleted = false;

		try {
			filmId = Integer.parseInt(filmid);
			if (filmId >= 1000)
				filmDeleted = filmDao.deleteFilmById(filmId);
		} catch (Exception e) {
			filmDeleted = false;
		}
		
		model.addAttribute("filmDeleted", filmDeleted);
		return "redirect:/searchFilm.do?filmid=" + searchTerm;		
	}

	@RequestMapping(path = "updateFilm.do")
	public String updateFilm(Model model, Film film) {

		boolean updated = filmDao.updateFilm(film);

		return "redirect:/showFilm.do?filmid=" + film.getId() + "&updated=" + updated;
	}

	@RequestMapping(path = "addFilm.do")
	public String addFilm(Model model, Film film) {
		
		int newId = filmDao.addFilm(film);
		
		boolean isAdded = (newId != -1);
		
		return "redirect:/showFilm.do?filmid=" + newId + "&added=" + isAdded; 
	}

	@RequestMapping(path = { "searchFilm.do" })
	public String searchByKeyWord(Model model, String filmid) {

		List<Film> films = null;

		try {
			films = filmDao.searchFilms(filmid);
		} catch (Exception e) {
			
		}
		model.addAttribute("searchTerm", filmid);
		model.addAttribute("films", films);
		
		return "WEB-INF/viewFilms.jsp";
	}
	
	@RequestMapping(path = { "showFilm.do" })
	public String showFilm(Model model, String filmid) {

		int filmId;
		Film f = null;

		try {
			filmId = Integer.parseInt(filmid);
			f = filmDao.getFilmById(filmId);
			if (f != null) {
				model.addAttribute("searchTerm", filmid);
				model.addAttribute("actors", f.getCast());
			}
		} catch (Exception e) {
		}
		model.addAttribute("film", f);
		
		return "WEB-INF/viewFilmbyId.jsp";
	}
}