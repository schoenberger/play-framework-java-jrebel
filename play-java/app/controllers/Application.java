package controllers;

import play.*;
import play.mvc.*;

import views.html.*;

import com.dependent.Test1;

public class Application extends Controller {

    public Result index() {
        return ok(
            "My                 time: Thu Oct  8 11:55:54 UTC 2015"+"\n"+
            "Dependency dynamic time: "+new Test1().get()+"\n"+
            "Dependency  static time: "+Test1.time
        );
    }

}
