package com.abhi.app.config;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.ImportResource;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@EnableWebSecurity
@Configuration
@EnableGlobalMethodSecurity(prePostEnabled=true)
@ImportResource("classpath:hibernate.xml")
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
		.antMatchers("/").permitAll()
		.antMatchers("/register").permitAll()
		.antMatchers("/signup").permitAll()
		.antMatchers("/forgot").permitAll()
		.antMatchers("/resources/**").permitAll()
		.antMatchers("/admin/**").hasAuthority("admin")
		.antMatchers("/**").authenticated()
		.and()
		.formLogin().loginPage("/").defaultSuccessUrl("/home").usernameParameter("username").passwordParameter("password")
		.and()
		.logout().deleteCookies("JSESSIONID").logoutUrl("/logout").logoutSuccessUrl("/");
		

	}
	
	//for hibernate
	@Autowired
	@Qualifier("myUserDetailsService")
    UserDetailsService userDetailsService;
	
	@Autowired
    public void configureGlobalSecurity(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
        auth.eraseCredentials(false);
    }
	
	
	public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
	
	
	

	/*//for memory authentication
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.inMemoryAuthentication().withUser("user").password("password").roles("USER");
		
	}*/
	
	@Autowired
	DataSource myDataSource;
	
	/*//for jdbc
	public void configAuthentication(AuthenticationManagerBuilder auth) throws Exception {
		auth.jdbcAuthentication().dataSource(myDataSource)
				.usersByUsernameQuery("select username,password from user where username=?")
				.authoritiesByUsernameQuery("select username, role from user where username=?");
	}*/

}