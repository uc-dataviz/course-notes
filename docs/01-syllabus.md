# (PART) Course information {.unnumbered}

# Syllabus

## Course description

Social scientists frequently wish to convey information to a broader audience in a cohesive and interpretable manner. Visualizations are an excellent method to summarize information and report analysis and conclusions in a compelling format. This course introduces the theory and applications of data visualization. We will establish this foundation using R and modern data visualization packages in R, most predominantly `ggplot2`.

To support this approach, we will focus on the what, why, and how of data visualization. "What" focuses on specific types of visualizations for a particular purpose, as well as tools in R for constructing these plots. In "how" we will focus on the process of generating a data visualization from pre-processing the raw data, mapping attributes of the data to plot aesthetics, strategically determining how to define the visual encoding of the data for maximal accessibility, and finalizing the visualization to consider the importance of visual appeal. In "why" we discuss the theory tying together the "how" and the "what", and consider empirical evidence of best-practices in data communication.

This course extends your prior training in the R programming language and extends your data science toolkit to a variety of data visualization packages. You will continue to employ common data science workflows for version control and collaboration, in particular with Git and GitHub.

## Learning objectives

By the end of the course, students will be able to:

- Understand the principles of designing and creating effective data visualizations.
- Evaluate, critique, and improve upon one's own and others' data visualizations based on how good a job the visualization does for communicating a message clearly and correctly.
- Post-process and refine plots for effective communication.
- Use visualizations for evaluating statistical models and for statistical inference.
- Master using R and a variety of modern data visualization packages to create data visualizations.
- Work reproducibly individually and collaboratively using Git and GitHub.

## Prerequisites

[MACS 30500](https://cfss.uchicago.edu) or an equivalent programming course in R. In particular, you should feel comfortable with the following operations in R:

- Importing data files
- Tidying and wrangling data
- Data transformation
- Data visualizations
- Reproducible documents and `rmarkdown`
- Core programming fundamentals (e.g. functions, iterative operations, conditional expressions)
- `tidyverse` approaches to data scientific operations in R
- Reproducible workflows
- Git/GitHub

## What do I need for this course?

Class sessions are a mix of lecture, demonstration, and live coding. It is essential to have a computer so you can follow along and complete the exercises. Before the course starts, you should install the following software on your computer:

* [R](https://www.r-project.org/) - easiest approach is to select [a pre-compiled binary appropriate for your operating system](https://cran.rstudio.com/).
* [RStudio IDE](https://www.rstudio.com/products/RStudio/) - this is a powerful user interface for programming in R. You could use base R, but you would regret it.
* [Git](https://git-scm.com/) - Git is a [version control system](https://en.wikipedia.org/wiki/Version_control) which is used to manage projects and track changes in computer files. Once installed, it can be integrated into RStudio to manage your course assignments and other projects.

Comprehensive instructions for downloading and setting up this software can be found [here](https://cfss.uchicago.edu/setup/#option-2-install-the-software-locally).

## Textbooks

We will draw from a variety of sources in this class. Primarily we will utilize the following textbooks. All are available electronically via open-source license.

1. Hadley Wickham, Danielle Navarro, and Thomas Lin Pedersen. [ggplot2: Elegant Graphics for Data Analysis](https://ggplot2-book.org/). (in progress) 3rd edition. Springer, 2021.
1. Claus O. Wilke. [Fundamentals of Data Visualization](https://clauswilke.com/dataviz/). O'Reilly Media, 2019.
1. Kieran Healy. [Data Visualization: A Practical Introduction](https://socviz.co/). Princeton University Press, 2018.

Additional readings will be assigned as necessary and will either be free electronically or on electronic course reserve via the UChicago library. All course reserves can be accessed through the course Canvas site.

## How will I be evaluated?

Assessment for the course is comprised of two components: homework assignments and projects.

-   **Homework assignments** (5), due every other week (roughly), completed individually.
    Each homework assignment is worth 10% of the course grade.

    Homework assignments are due by 11am (beginning of class) on the indicated day on the [course schedule](./schedule.html).

-   **Projects** (2), mid-quarter and end of quarter, completed in teams.

    -   Project 1: Teams will be given a dataset to visualize. Project 1 is worth 20% of the course grade.
    -   Project 2: Teams will pick a dataset of interest to them and/or build an R package that implements a new type of data visualization in R. Project 2 is worth 30% of the course grade.

    The deliverables for each project will include a data visualization, a write up of the process and findings, and a presentation.
    For the second project, you will be encouraged to think beyond a traditional two-dimensional data visualization (e.g. interactive web apps/dashboards, data art, generative art, physical/tangible visualizations, **ggplot2** extensions, etc.).

    Each project will have a peer review component to provide at least one round of feedback during the process of development.
    Teams will provide periodic peer feedback to their teammates while working on the projects as well as upon completion.
    The scores from the peer evaluations, along with individual contributions tracked by commits on GitHub, will be used to ensure that each student has contributed to the teamwork.

    All team members must take part in the presentation.

All work is expected to be submitted by the deadline and there are no make ups for any missed assessments.

See [Late work policy] for policies on late work.

In summary, your course grade will be comprised of the following:

|                      |     |
|----------------------|-----|
| Homework assignments | 50% |
| Project 1            | 20% |
| Project 2            | 30% |

The exact ranges for letter grades will be curved and cutoffs will be determined at the end of the semester. The more evidence there is that the class has mastered the material, the more generous the curve will be.

## Teams

You will be assigned to a different team for each of your two projects. You are encouraged to sit with your teammates in lecture. All team members are expected to contribute equally to the completion of each project and you will be asked to evaluate your team members after each assignment is due. Failure to adequately contribute to an assignment will result in a penalty to your mark relative to the team's overall mark.

You are expected to make use of the provided GitHub repository as their central collaborative platform. Commits to this repository will be used as a metric (one of several) of each team member's relative contribution for each project.

## Support

Most of you will need help at some point and we want to make sure you can identify when that is without getting too frustrated and feel comfortable seeking help.

### Office hours

Office hours (with me and the teaching assistant) are the best time to get your questions answered about course content as well as to hear what others are asking about and learn from their questions.

I encourage each and every one of you to take advantage of this resource! Make a pledge to stop by office hours at least once during the first three weeks of class. If you truly have no questions to ask, just stop by and say hi and introduce yourself.

Our office hours are listed [here](./teaching-team.html).

### Discussion forum

Have a question that can't wait for office hours? Prefer to write out your question in detail rather than asking in person? The online discussion forum is the best venue for these!

We will use GitHub Discussions as the online discussion forum. We will demo how to use the forum and give access to all enrolled students to the private GitHub repository that houses the forum during the first week of classes.

Please refrain from emailing any course content questions (those should go GitHub Discussions), and only use email for questions about personal matters that may not be appropriate for the public course forum (e.g., illness, late work).

## Statement on Disabilities

The University of Chicago is committed to diversity and rigorous inquiry from multiple perspectives. The MAPSS, CIR, and Computation programs share this commitment and seek to foster productive learning environments based upon inclusion, open communication, and mutual respect for a diverse range of identities, experiences, and positions.

This course is open to all students who meet the academic requirements for participation. Any student who has a documented need for accommodation should contact Student Disability Services (773-702-6000 or [disabilities@uchicago.edu](mailto:disabilities@uchicago.edu)) and provide me (Dr. Soltoff) with a copy of your Accommodation Determination Letter as soon as possible.

## Policies

### Collaboration policy

Only work that is clearly assigned as team work should be completed collaboratively.

-   The homework assignments must  be completed individually and you are welcome to discuss the assignment with classmates at a high level (e.g., discuss what's the best way for approaching a problem, what functions are useful for accomplishing a particular task, etc.). However you may not directly share answers to homework questions (including any code) with anyone other than myself and the teaching assistant.
-   For the projects, collaboration within teams is not only allowed, but expected. Communication between teams at a high level is also allowed however you may not share code or components of the project across teams.

### Policy on sharing and reusing code

I am well aware that a huge volume of code is available on the web to solve any number of problems. Unless I explicitly tell you not to use something, the course's policy is that you may make use of any online resources (e.g. RStudio Community, StackOverflow) but you must explicitly cite where you obtained any code you directly use (or use as inspiration).

Any recycled code that is discovered and is not explicitly cited will be treated as plagiarism. On individual assignments you may not directly share code with another student in this class, and on team assignments you may not directly share code with another team in this class.

### Late work policy

Policy on late work depends on the particular course component:

-   Homework assignments: GitHub repositories will be closed to contributions at the deadline.
    If you need to submit your work late, email me to reopen your repository.

    -   Late, but same day (before midnight): -10% of available points

    -   Late, but next day: -20% of available points

    -   Two days late or later: No credit, and we will not provide written feedback

-   Projects: The following three components contribute to your project score.

    -   Presentation: Late presentations are not accepted and there are no make ups for missed presentations.

    -   Write up: GitHub repositories will be closed to contributions at the deadline.
        If you need to submit your work late, email me to reopen your repository.

        -   Late, but same day (before midnight): -10% of available points

        -   Late, but next day: -20% of available points

        -   Two days late or later: No credit, and we will not provide written feedback

    -   Peer evaluation: Late peer evaluations are not accepted and there are no make ups for missed presentations.
        If you do not turn in your peer evaluation, you get 0 points for your own peer score as well, regardless of how your teammates have evaluated you.

### Attendance policy

Responsibility for class attendance rests with individual students. Since regular and punctual class attendance is expected, students must accept the consequences of failure to attend. However, there may be many reasons why you cannot be in class on a given day, particularly with possible extra personal and academic stress and health concerns this quarter.

In short, all of you are adults and can make the decision whether or not to attend class.

### Attendance policy related to COVID symptoms, exposure, or infection

Student health, safety, and well-being are the University's top priorities. Please follow the University's [exposure protocol](https://uchicago.app.box.com/s/osmchf84e34uh2v4sqm03s4skfsxc85o) if you are exposed to COVID-19.

To help ensure your well-being and the well-being of those around you, please do not come to class if you have symptoms related to COVID-19, have had a known exposure to COVID-19, or have tested positive for COVID-19. If any of these situations apply to you, you must follow university guidance related to the ongoing COVID-19 pandemic and current health and safety protocols.

Please reach out to me as soon as possible if you need to quarantine or isolate so that we can discuss arrangements for your continued participation in class.

## Acknowledgments

Materials for this course are drawn from the past times I taught the class (spring 2017, 2018) as well as other excellent resources online. These include:

- [STA/ISS 313 - Advanced Data Visualization by Mine Çetinkaya-Rundel](https://www.vizdata.org/index.html), licensed under a [Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/).
- [PMAP 8921 - Data Visualization by Andrew Young](https://datavizs21.classes.andrewheiss.com/), licensed under a [Creative Commons Attribution-NonCommercial 4.0 International License](https://creativecommons.org/licenses/by-nc/4.0/).
