package com.spvue.ex.model;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
 
@Entity
@Table(name = "customer")
public class Customer {
 
  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private long id;
 
  @Column(name = "name")
  private String name;
 
  @Column(name = "age")
  private int age;
  
  @Column(name = "sex")
  private String sex;
 
  @Column(name = "active")
  private boolean active;
 

public Customer() {
}

public Customer(String name, int age,String sex) {
    this.name = name;
    this.age = age;
    this.sex = sex;
    this.active = false;
  }
 
  public long getId() {
    return id;
  }
 
  public void setName(String name) {
    this.name = name;
  }
 
  public String getName() {
    return this.name;
  }
  
  public void setSex(String sex) {
	  this.sex = sex;
  }
  
  public String getSex() {
	  return this.sex;
  }
 
  public void setAge(int age) {
    this.age = age;
  }
 
  public int getAge() {
    return this.age;
  }
 
  public boolean isActive() {
    return active;
  }
 
  public void setActive(boolean active) {
    this.active = active;
  }
  
  @Override
  public String toString() {
    return "Customer [id=" + id + ", name=" + name + ", age=" + age + ", sex=" + sex + ", active=" + active + "]";
  }
}
  




