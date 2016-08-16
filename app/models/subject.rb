class Subject < ActiveRecord::Base
    has_many :evaluations
    has_many :users, through: :evalstatuses


def self.search(term)
    where('LOWER(name) LIKE :term OR LOWER(prof) LIKE :term', term: "%#{term.downcase}%")
end
Subject.where()
def self.search2(term)
    @a = term.split('-')
    @b = @a.size
        if @b == 1
            where('LOWER(name) LIKE :term OR LOWER(prof) LIKE :term', term: "%#{term.downcase}%")
        elsif term == ""
         where('LOWER(name) LIKE :term OR LOWER(prof) LIKE :term')
        else
            whole = term.split('-')
            title = whole.first
            prof = whole.second
            where('LOWER(name) LIKE :title AND LOWER(prof) LIKE :prof', title: "%#{title.downcase}%", prof: "%#{prof.downcase}%")
        end
end

def self.search3(a, b, c)
    if c != "전체"
    where(:name => c, :division => a, :dept => b)
    else
    where(:division => a, :dept => b)
    end
end
end
